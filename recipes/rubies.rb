#
# Cookbook Name:: rvm
# Recipe:: rubies
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

ruby_version = node['rvm']['rubies']['version']

execute 'install_ruby' do
  command "rvm install #{ruby_version}"
  notifies :run, 'execute[default_ruby]', :immediately
end

execute 'default_ruby' do
  command "rvm --default use #{ruby_version}"
end
