#
# Cookbook Name:: rvm_sl
# Recipe:: user_install
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

user_name = node['rvm']['user']['name']
user_password = node['rvm']['user']['password']
home = "/home/#{user_name}"
keyserver = node['rvm']['keyserver']
recv_keys = node['rvm']['recv-keys']

include_recipe 'rvm_sl::system_requirements'

ruby_block 'installing_rvm' do
  block do
    cmd = Mixlib::ShellOut.new(
      "gpg --keyserver #{keyserver} --recv-keys #{recv_keys}",
      user: user_name, password: user_password, cwd: home)
    cmd.run_command
    cmd.error!

    cmd = Mixlib::ShellOut.new(
      '\curl -sSL https://get.rvm.io | bash -s stable',
      user: user_name, password: user_password, cwd: home)
    cmd.run_command
    cmd.error!
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
