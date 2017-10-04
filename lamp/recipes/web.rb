#
# Cookbook:: lamp
# Recipe:: web
#
# Copyright:: 2017, The Authors, All Rights Reserved.
directory node['lamp']['web']['document_root'] do
  recursive true
end

httpd_config 'default' do
  source 'default.conf.erb'
end

httpd_service 'default' do
  mpm 'prefork'
  action [:create, :start]
  subscribes :restart, 'httpd_config[default]'
end

# Install the mod_php5 Apache module.
httpd_module 'php5' do
  instance 'default'
end

# Install php5-mysql.
package 'php5-mysql' do
  action :install
  notifies :restart, 'httpd_service[default]'
end
