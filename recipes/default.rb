#
# Cookbook Name:: apache2_windows
# Recipe:: default
#
# Copyright 2013, Opscode, Inc.
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
#

require 'chef/exceptions'

unless node['platform_family'] == 'windows'
  raise Chef::Exceptions::Application, "This cookbook only works on Microsoft Windows."
end

require 'win32/service'

# requires matching VC runtime
include_recipe "vcruntime::#{node['apache']['windows']['version'].split('.')[3].downcase}"

# init directory
directory "#{node['apache']['windows']['topdir']}" do
  action :create
end

# unzip apachelounge binaries to directory
windows_zipfile "#{node['apache']['windows']['topdir']}" do
  source node['apache']['windows']['source']
  action :unzip
  not_if {::Dir.exists?("#{node['apache']['windows']['topdir']}/Apache24")}
end

directory "#{node['apache']['windows']['conf_dir']}" do
  action :create
end

# install service if necessary
execute "#{node['apache']['windows']['bin_dir']}/httpd.exe -k install" do
  not_if {::Win32::Service.exists?("apache2.4")}
end

# write config file
template node['apache']['windows']['conf'] do
  source "httpd.conf.erb"
  action :create
  notifies :restart, "service[apache2]"
end

node['apache']['windows']['extras'].each do |extra|
  include_recipe "apache2_windows::_extra_#{extra}"
end

windows_firewall_rule "Apache (Chef)" do
  localport '80'
  protocol :TCP
  firewall_action :allow
  profile :private
  dir :in
  program "#{node['apache']['windows']['bin_dir']}/httpd.exe".gsub('/', '\\')
end

# Start apache service
service "apache2" do
  service_name node['apache']['windows']['servicename']
  action [ :enable, :start ]
end
