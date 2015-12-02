#
# Cookbook Name:: rvm_sl
# Recipe:: rubies
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

user_name = node['rvm']['user']['name']
home = "/home/#{user_name}"

ruby_version = node['rvm']['rubies']['version']

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
    bash -l -c 'rvm install #{ruby_version}'
    bash -l -c 'rvm --default use #{ruby_version}'
  END
end

execute 'chown_rvm_dir' do
  command "chown -R #{user_name}:rvm #{home}/.rvm"
  action :run
end
