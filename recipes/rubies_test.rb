#
# Cookbook Name:: rvm_sl
# Recipe:: rubies
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

node.default['rvm']['user']['name'] = 'vagrant'
node.default['rvm']['user']['password'] = 'vagrant'
node.default['rvm']['user']['home'] = '/home/vagrant'

include_recipe 'rvm_sl::user_install'

rvm_rubies 'ruby-2.2.3' do
  default true
  home '/home/vagrant'
  user_name 'vagrant'
  version '2.2.3'
end
