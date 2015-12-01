#
# Cookbook Name:: rvm_sl
# Recipe:: rubies
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

user_name = node['rvm_sl']['user']['name']
home = "/home/#{user_name}"

ruby_version = node['rvm_sl']['rubies']['version']

group 'rvm' do
  members [user_name, 'root']
  append true
end

group 'admin' do
  members [user_name]
  append true
end

execute 'install_ruby' do
  environment 'HOME' => '/home/vagrant'
  command <<-END
    bash -l -c 'rvm_sl install #{ruby_version}'
    bash -l -c 'rvm_sl --default use #{ruby_version}'
  END
end

execute 'chown_rvm_sl_dir' do
  command "chown -R #{user_name}:rvm_sl #{home}/.rvm_sl"
  action :run
end
