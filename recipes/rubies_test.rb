#
# Cookbook Name:: rvm_sl
# Recipe:: rubies_test
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'rvm_sl::user_install'

rvm_rubies 'ruby-2.2.3' do
  default true
  home '/home/vagrant'
  user_name 'vagrant'
  version '2.2.3'
end
