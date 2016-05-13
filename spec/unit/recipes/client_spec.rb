#
# Cookbook Name:: satellite6
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'satellite6::client' do
  platforms = {
    'redhat' => {
      'versions' => ['5.10', '6.6', '7.1']
    }
  }
  platforms.keys.each do |platform|
    platforms[platform]['versions'].each do |version|
      mypath = "spec/fixtures/fauxhai/#{platform}/#{version}.json"
      context "On #{platform} #{version}" do
        context 'When all attributes are default, on a satellite server' do
          cached(:chef_run) do
            ChefSpec::ServerRunner.new(platform: platform, version: version, path: mypath) do |node, server|
              loadfixtures(server)

              node.automatic['fqdn'] = 'satellite6.example.com'
              node.set['chef_environment'] = 'prod'
              node.set['environment'] = 'prod'
              allow(node).to receive(:environment).and_return('prod')
              allow(node).to receive(:chef_environment).and_return('prod')
            end.converge(described_recipe)
          end

          it 'converges successfully' do
            chef_run # This should not raise an error
          end
        end
      end
    end
  end
end
