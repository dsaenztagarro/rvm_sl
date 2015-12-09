#
# Cookbook Name:: rvm_sl
# Recipe:: user_install
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

user_name = node['rvm']['user']['name']
home = node['rvm']['user']['home']
keyserver = node['rvm']['keyserver']
recv_keys = node['rvm']['recv-keys']

include_recipe 'rvm_sl::system_requirements'

ruby_block 'installing_rvm' do
  block do
    opts = { user: user_name }
    login_shell!("gpg --keyserver #{keyserver} --recv-keys #{recv_keys}", opts)
    login_shell!('\curl -sSL https://get.rvm.io | bash -s stable', opts)
  end
  action :run
  not_if 'which rvm'
end

execute 'bootstraping_bashrc' do
  command "echo '[[ -s \"$HOME/.rvm/scripts/rvm\" ]] && " \
          "source \"$HOME/.rvm/scripts/rvm\"' >> .bashrc"
  user user_name
  cwd home
  not_if "grep -q rvm #{home}/.bashrc"
end

group 'rvm' do
  members [user_name, 'root']
  append true
end
