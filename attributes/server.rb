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
default['katello']['server']['include_iptables'] = true
default['katello']['server']['include_ntp'] = true
m = /(?<d>\w+\.\w+)$/.match(node['fqdn'])

default['katello']['server']['conf']['capsule']['parent_fqdn'] = node['fqdn']
default['katello']['server']['conf']['capsule']['certs_tar'] = nil
default['katello']['server']['conf']['capsule']['pulp'] = false
default['katello']['server']['conf']['capsule']['pulp_master'] = true
default['katello']['server']['conf']['capsule']['pulp_admin_password'] = nil
default['katello']['server']['conf']['capsule']['pulp_oauth_effective_user'] = 'admin'
default['katello']['server']['conf']['capsule']['pulp_oauth_key'] = 'katello'
default['katello']['server']['conf']['capsule']['pulp_oauth_secret'] = nil
default['katello']['server']['conf']['capsule']['foreman_proxy_port'] = 9090
default['katello']['server']['conf']['capsule']['foreman_proxy_http'] = true
default['katello']['server']['conf']['capsule']['foreman_proxy_http_port'] = 8000
default['katello']['server']['conf']['capsule']['puppet'] = true
default['katello']['server']['conf']['capsule']['puppetca'] = true
default['katello']['server']['conf']['capsule']['puppet_ca_proxy'] = ''
default['katello']['server']['conf']['capsule']['reverse_proxy'] = false
default['katello']['server']['conf']['capsule']['reverse_proxy_port'] = '8443'
default['katello']['server']['conf']['capsule']['tftp'] = true
default['katello']['server']['conf']['capsule']['tftp_syslinux_root'] = nil
default['katello']['server']['conf']['capsule']['tftp_syslinux_files'] = nil
default['katello']['server']['conf']['capsule']['tftp_root'] = '/var/lib/tftpboot/'
default['katello']['server']['conf']['capsule']['tftp_dirs'] \
  = ['/var/lib/tftpboot//pxelinux.cfg', '/var/lib/tftpboot//boot']
default['katello']['server']['conf']['capsule']['tftp_servername'] = nil
default['katello']['server']['conf']['capsule']['bmc'] = false
default['katello']['server']['conf']['capsule']['bmc_default_provider'] = 'ipmitool'
default['katello']['server']['conf']['capsule']['dhcp'] = true
default['katello']['server']['conf']['capsule']['dhcp_listen_on'] = 'https'
default['katello']['server']['conf']['capsule']['dhcp_option_domain'] = [node['domain'], m['d']]
default['katello']['server']['conf']['capsule']['dhcp_managed'] = true
default['katello']['server']['conf']['capsule']['dhcp_interface'] = node['network']['default_interface']
default['katello']['server']['conf']['capsule']['dhcp_gateway'] = node['network']['default_gateway']
default['katello']['server']['conf']['capsule']['dhcp_range'] = false
default['katello']['server']['conf']['capsule']['dhcp_nameservers'] = 'default'
default['katello']['server']['conf']['capsule']['dhcp_vendor'] = 'isc'
default['katello']['server']['conf']['capsule']['dhcp_config'] = '/etc/dhcp/dhcpd.conf'
default['katello']['server']['conf']['capsule']['dhcp_leases'] = '/var/lib/dhcpd/dhcpd.leases'
default['katello']['server']['conf']['capsule']['dhcp_key_name'] = ''
default['katello']['server']['conf']['capsule']['dhcp_key_secret'] = ''
default['katello']['server']['conf']['capsule']['dns'] = true
default['katello']['server']['conf']['capsule']['dns_managed'] = true
default['katello']['server']['conf']['capsule']['dns_provider'] = 'nsupdate'
default['katello']['server']['conf']['capsule']['dns_zone'] = node['domain']
default['katello']['server']['conf']['capsule']['dns_reverse'] = '100.168.192.in-addr.arpa'
default['katello']['server']['conf']['capsule']['dns_interface'] = node['network']['default_interface']
default['katello']['server']['conf']['capsule']['dns_server'] = '127.0.0.1'
default['katello']['server']['conf']['capsule']['dns_ttl'] = '86400'
default['katello']['server']['conf']['capsule']['dns_tsig_keytab'] = '/etc/foreman-proxy/dns.keytab'
default['katello']['server']['conf']['capsule']['dns_tsig_principal'] \
  = "foremanproxy/#{node['fqdn']}@#{m['d'].upcase}"
default['katello']['server']['conf']['capsule']['dns_forwarders'] = []
default['katello']['server']['conf']['capsule']['virsh_network'] = 'default'
default['katello']['server']['conf']['capsule']['realm'] = false
default['katello']['server']['conf']['capsule']['realm_provider'] = 'freeipa'
default['katello']['server']['conf']['capsule']['realm_keytab'] = '/etc/foreman-proxy/freeipa.keytab'
default['katello']['server']['conf']['capsule']['realm_principal'] = 'realm-proxy@EXAMPLE.COM'
default['katello']['server']['conf']['capsule']['freeipa_remove_dns'] = true
default['katello']['server']['conf']['capsule']['register_in_foreman'] = true
default['katello']['server']['conf']['capsule']['foreman_oauth_effective_user'] = 'admin'
default['katello']['server']['conf']['capsule']['foreman_oauth_key'] = nil
default['katello']['server']['conf']['capsule']['foreman_oauth_secret'] = nil
default['katello']['server']['conf']['capsule']['rhsm_url'] = '/rhsm'
default['katello']['server']['conf']['capsule']['templates'] = false
default['katello']['server']['conf']['capsule']['qpid_router'] = true
default['katello']['server']['conf']['capsule']['qpid_router_hub_addr'] = '0.0.0.0'
default['katello']['server']['conf']['capsule']['qpid_router_hub_port'] = '5646'
default['katello']['server']['conf']['capsule']['qpid_router_agent_addr'] = '0.0.0.0'
default['katello']['server']['conf']['capsule']['qpid_router_agent_port'] = '5647'
default['katello']['server']['conf']['capsule']['qpid_router_broker_addr'] = node['fqdn']
default['katello']['server']['conf']['capsule']['qpid_router_broker_port'] = '5671'

default['katello']['server']['conf']['certs']['log_dir'] = '/var/log/certs'
default['katello']['server']['conf']['certs']['node_fqdn'] = node['fqdn']
default['katello']['server']['conf']['certs']['generate'] = true
default['katello']['server']['conf']['certs']['regenerate'] = false
default['katello']['server']['conf']['certs']['regenerate_ca'] = false
default['katello']['server']['conf']['certs']['deploy'] = true
default['katello']['server']['conf']['certs']['ca_common_name'] = node['fqdn']
default['katello']['server']['conf']['certs']['country'] = 'US'
default['katello']['server']['conf']['certs']['state'] = 'North Carolina'
default['katello']['server']['conf']['certs']['city'] = 'Raleigh'
default['katello']['server']['conf']['certs']['org'] = 'Katello'
default['katello']['server']['conf']['certs']['org_unit'] = 'SomeOrgUnit'
default['katello']['server']['conf']['certs']['expiration'] = '7300'
default['katello']['server']['conf']['certs']['ca_expiration'] = '36500'
default['katello']['server']['conf']['certs']['server_cert'] = nil
default['katello']['server']['conf']['certs']['server_key'] = nil
default['katello']['server']['conf']['certs']['server_cert_req'] = nil
default['katello']['server']['conf']['certs']['server_ca_cert'] = nil
default['katello']['server']['conf']['certs']['pki_dir'] = '/etc/pki/katello'
default['katello']['server']['conf']['certs']['ssl_build_dir'] = '/root/ssl-build'
default['katello']['server']['conf']['certs']['password_file_dir'] = 'certs::params::password_file_dir'
default['katello']['server']['conf']['certs']['user'] = 'root'
default['katello']['server']['conf']['certs']['group'] = 'foreman'
default['katello']['server']['conf']['certs']['default_ca_name'] = 'katello-default-ca'
default['katello']['server']['conf']['certs']['server_ca_name'] = 'katello-server-ca'

default['katello']['server']['conf']['foreman']['foreman_url'] = "https://#{node['fqdn']}"
default['katello']['server']['conf']['foreman']['unattended'] = true
default['katello']['server']['conf']['foreman']['authentication'] = true
default['katello']['server']['conf']['foreman']['passenger'] = true
default['katello']['server']['conf']['foreman']['passenger_scl'] = nil
default['katello']['server']['conf']['foreman']['passenger_ruby'] = '/usr/bin/ruby193-ruby'
default['katello']['server']['conf']['foreman']['passenger_ruby_package'] = 'ruby193-rubygem-passenger-native'
default['katello']['server']['conf']['foreman']['use_vhost'] = true
default['katello']['server']['conf']['foreman']['servername'] = node['fqdn']
default['katello']['server']['conf']['foreman']['ssl'] = true
default['katello']['server']['conf']['foreman']['custom_repo'] = true
default['katello']['server']['conf']['foreman']['repo'] = 'stable'
default['katello']['server']['conf']['foreman']['configure_epel_repo'] = false
default['katello']['server']['conf']['foreman']['configure_scl_repo'] = false
default['katello']['server']['conf']['foreman']['configure_brightbox_repo'] = false
default['katello']['server']['conf']['foreman']['selinux'] = nil
default['katello']['server']['conf']['foreman']['gpgcheck'] = true
default['katello']['server']['conf']['foreman']['version'] = 'present'
default['katello']['server']['conf']['foreman']['db_manage'] = true
default['katello']['server']['conf']['foreman']['db_type'] = 'postgresql'
default['katello']['server']['conf']['foreman']['db_adapter'] = nil
default['katello']['server']['conf']['foreman']['db_host'] = nil
default['katello']['server']['conf']['foreman']['db_port'] = nil
default['katello']['server']['conf']['foreman']['db_database'] = nil
default['katello']['server']['conf']['foreman']['db_username'] = 'foreman'
default['katello']['server']['conf']['foreman']['db_password'] = nil
default['katello']['server']['conf']['foreman']['db_sslmode'] = nil
default['katello']['server']['conf']['foreman']['app_root'] = '/usr/share/foreman'
default['katello']['server']['conf']['foreman']['user'] = 'foreman'
default['katello']['server']['conf']['foreman']['group'] = 'foreman'
default['katello']['server']['conf']['foreman']['user_groups'] = ['puppet']
default['katello']['server']['conf']['foreman']['environment'] = 'production'
default['katello']['server']['conf']['foreman']['puppet_home'] = '/var/lib/puppet'
default['katello']['server']['conf']['foreman']['locations_enabled'] = true
default['katello']['server']['conf']['foreman']['organizations_enabled'] = true
default['katello']['server']['conf']['foreman']['passenger_interface'] = ''
default['katello']['server']['conf']['foreman']['server_ssl_ca'] = '/etc/pki/katello/certs/katello-default-ca.crt'
default['katello']['server']['conf']['foreman']['server_ssl_chain'] = '/etc/pki/katello/certs/katello-default-ca.crt'
default['katello']['server']['conf']['foreman']['server_ssl_cert'] = '/etc/pki/katello/certs/katello-apache.crt'
default['katello']['server']['conf']['foreman']['server_ssl_key'] = '/etc/pki/katello/private/katello-apache.key'
default['katello']['server']['conf']['foreman']['oauth_active'] = true
default['katello']['server']['conf']['foreman']['oauth_map_users'] = false
default['katello']['server']['conf']['foreman']['oauth_consumer_key'] = nil
default['katello']['server']['conf']['foreman']['oauth_consumer_secret'] = nil
default['katello']['server']['conf']['foreman']['passenger_prestart'] = true
default['katello']['server']['conf']['foreman']['passenger_min_instances'] = '1'
default['katello']['server']['conf']['foreman']['passenger_start_timeout'] = '600'
default['katello']['server']['conf']['foreman']['admin_username'] = 'admin'
default['katello']['server']['conf']['foreman']['admin_password'] = nil
default['katello']['server']['conf']['foreman']['admin_first_name'] = nil
default['katello']['server']['conf']['foreman']['admin_last_name'] = nil
default['katello']['server']['conf']['foreman']['admin_email'] = nil
default['katello']['server']['conf']['foreman']['initial_organization'] = 'Default Organization'
default['katello']['server']['conf']['foreman']['initial_location'] = 'Default Location'
default['katello']['server']['conf']['foreman']['ipa_authentication'] = false
default['katello']['server']['conf']['foreman']['http_keytab'] = '/etc/httpd/conf/http.keytab'
default['katello']['server']['conf']['foreman']['pam_service'] = 'foreman'
default['katello']['server']['conf']['foreman']['configure_ipa_repo'] = false
default['katello']['server']['conf']['foreman']['ipa_manage_sssd'] = true
default['katello']['server']['conf']['foreman']['websockets_encrypt'] = true
default['katello']['server']['conf']['foreman']['websockets_ssl_key'] = '/etc/pki/katello/private/katello-apache.key'
default['katello']['server']['conf']['foreman']['websockets_ssl_cert'] = '/etc/pki/katello/certs/katello-apache.crt'

default['katello']['server']['conf']['foreman::plugin::bootdisk'] = {}
default['katello']['server']['conf']['foreman::plugin::chef'] = false
default['katello']['server']['conf']['foreman::plugin::default_hostgroup'] = false
default['katello']['server']['conf']['foreman::plugin::discovery'] = false
default['katello']['server']['conf']['foreman::plugin::hooks'] = {}
default['katello']['server']['conf']['foreman::plugin::puppetdb'] = false
default['katello']['server']['conf']['foreman::plugin::setup'] = false
default['katello']['server']['conf']['foreman::plugin::tasks'] = {}
default['katello']['server']['conf']['foreman::plugin::templates'] = false

default['katello']['server']['conf']['katello']['user'] = 'foreman'
default['katello']['server']['conf']['katello']['group'] = 'foreman'
default['katello']['server']['conf']['katello']['user_groups'] = 'foreman'
default['katello']['server']['conf']['katello']['oauth_key'] = 'katello'
default['katello']['server']['conf']['katello']['oauth_secret'] = nil
default['katello']['server']['conf']['katello']['post_sync_token'] = nil
default['katello']['server']['conf']['katello']['log_dir'] = '/var/log/foreman/plugins'
default['katello']['server']['conf']['katello']['config_dir'] = '/etc/foreman/plugins'
default['katello']['server']['conf']['katello']['use_passenger'] = 'katello::params::use_passenger'
default['katello']['server']['conf']['katello']['proxy_url'] = nil
default['katello']['server']['conf']['katello']['proxy_port'] = nil
default['katello']['server']['conf']['katello']['proxy_username'] = nil
default['katello']['server']['conf']['katello']['proxy_password'] = nil
default['katello']['server']['conf']['katello']['cdn_ssl_version'] = nil
default['katello']['server']['conf']['katello']['package_names'] = ['katello', 'ruby193-rubygem-katello']
default['katello']['server']['conf']['katello::plugin::gutterball'] = {}
