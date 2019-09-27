# Cookbook Name:: satellite6
# Recipe:: server
#
# Copyright 2016 Secureworks
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)

node.default['java']['install_flavor'] = 'openjdk'
node.default['java']['jdk_version'] = 7

node.default['katello']['server']['install_cmd'] \
  = '/sbin/katello-installer -d >> chef.log 2>&1; echo $? > chef-exec.exit; exit $(cat chef-exec.exit)'

my_length = 20
if node['katello']['server']['conf']['capsule']['pulp_admin_password'].nil?
  node.normal['katello']['server']['conf']['capsule']['pulp_admin_password'] \
    = random_password(length: my_length, mode: :base64)
end
if node['katello']['server']['conf']['foreman']['db_password'].nil?
  node.normal['katello']['server']['conf']['foreman']['db_password'] \
    = random_password(length: my_length, mode: :base64)
end
if node['katello']['server']['conf']['foreman']['admin_password'].nil?
  node.normal['katello']['server']['conf']['foreman']['admin_password'] \
    = random_password(length: my_length, mode: :base64)
end
if node['katello']['server']['conf']['capsule']['foreman_oauth_key'].nil?
  p = random_password(length: my_length, mode: :base64)
  node.normal['katello']['server']['conf']['capsule']['foreman_oauth_key'] = p
  node.normal['katello']['server']['conf']['foreman']['oauth_consumer_key'] = p
end
if node['katello']['server']['conf']['capsule']['foreman_oauth_secret'].nil?
  p = random_password(length: my_length, mode: :base64)
  node.normal['katello']['server']['conf']['capsule']['foreman_oauth_secret'] = p
  node.normal['katello']['server']['conf']['foreman']['oauth_consumer_secret'] = p
end
if node['katello']['server']['conf']['katello']['oauth_secret'].nil?
  node.normal['katello']['server']['conf']['katello']['oauth_secret'] \
    = random_password(length: my_length, mode: :base64)
end
if node['katello']['server']['conf']['katello']['post_sync_token'].nil?
  node.normal['katello']['server']['conf']['katello']['post_sync_token'] \
    = random_password(length: my_length, mode: :base64)
end

service 'rhsmcertd' do
  action [:enable, :start]
end

execute 'repolist' do
  command '/bin/yum repolist -d0 -e0 >/dev/null 2>&1'
  action :nothing
end

template '/etc/rhsm/rhsm.conf' do
  source 'rhsm.conf.erb'
  owner 'root'
  group 'root'
  mode 00644
  sensitive true
  variables(
    lazy { { katello: node['katello']['server'] } }
  )
  notifies :restart, 'service[rhsmcertd]', :immediately
  notifies :run, 'execute[repolist]', :immediately
end

include_recipe 'java'
include_recipe 'chef-sugar::default'
include_recipe 'selinux::default'
include_recipe 'ntp::default' if node['katello']['server']['include_ntp']
include_recipe 'iptables::default' if node['katello']['server']['include_iptables']

# Pre install as many packages at once, prime the pump for puppet
packages = %w(
  katello
  pulp-admin-client
  pulp-rpm-admin-extensions
  pulp-rpm-handlers
  ruby193-rubygem-passenger-native
  foreman-postgresql
  katello-certs-tools
  mod_passenger
  puppet-server
  qpid-dispatch-router
  ruby193-rubygem-passenger-native
  rubygem-smart_proxy_pulp
  dhcp
  bind
  tftp-server
)

package packages do
  action :install
end

iptables_rule '01_system_default_start' do
  action :enable
  only_if { node['katello']['server']['include_iptables'] }
end

iptables_rule '05_iptables_prerequisites' do
  action :enable
  only_if { node['katello']['server']['include_iptables'] }
end

if vagrant?
  ENV.keys.each do |key|
    ENV.delete(key) if key =~ /proxy/i
  end
end

execute 'katello-installer' do
  cwd '/var/log/katello-installer'
  command node['katello']['server']['install_cmd']
  action :nothing
end

# Even though it's passed the -d flag, puppet still reads in the .yml, reformats it, writes it back out
# So to keep from regenerating every time, we need to actually compare the two.
answers_file = '/etc/katello-installer/answers.katello-installer.yaml'
puppet_guard1 = node['katello']['server']['conf'].to_h
puppet_guard2 = YAML.load_file(answers_file).to_h if File.exist?(answers_file)
Chef::Log.warn("puppet-config-guard: #{puppet_guard1 != puppet_guard2}")

template answers_file do
  source 'answers.katello-installer.yaml.erb'
  owner 'root'
  group 'root'
  mode 00600
  sensitive true
  variables(
    lazy { { config: node['katello']['server']['conf'] } }
  )
  notifies :run, 'execute[katello-installer]', :immediately
  only_if { puppet_guard1 != puppet_guard2 }
end

katello_guard = Mixlib::ShellOut.new('exit $(cat /var/log/katello-installer/chef-exec.exit)')
katello_guard.run_command
Chef::Log.warn("katello-exit-guard: #{katello_guard.error?}")

execute 'katello-installer-safety' do
  cwd '/var/log/katello-installer'
  command node['katello']['server']['install_cmd']
  action :run
  only_if { katello_guard.error? }
end

katello_services = %w(
  mongod
  qpidd
  qdrouterd
  tomcat
  foreman-proxy
  postgresql
  pulp_celerybeat
  pulp_resource_manager
  pulp_workers
  httpd
  foreman-tasks
)
katello_services.each do |ks|
  service ks do
    action [:enable, :start]
  end
end
service 'dhcpd' do
  action [:enable, :start]
  only_if { node['katello']['server']['conf']['capsule']['dhcp'] }
end

service 'named' do
  action [:enable, :start]
  only_if { node['katello']['server']['conf']['capsule']['dns'] }
end

iptables_rule '06_iptables_postinstall' do
  action :enable
  only_if { node['katello']['server']['include_iptables'] }
end

iptables_rule '10_system_default_end' do
  action :enable
  only_if { node['katello']['server']['include_iptables'] }
end
