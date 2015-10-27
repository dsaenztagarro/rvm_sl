#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

home = node['rvm']['user']['dir']

file 'lockrvm' do
  action :create_if_missing
  name "#{home}/.lockrvm"
  notifies :run, 'execute[initrvm]', :immediately
end

execute 'initrvm' do
  command 'curl -sSL https://get.rvm.io | bash -s stable'
  action :nothing
end
