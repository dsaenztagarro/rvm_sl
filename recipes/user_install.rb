#
# Cookbook Name:: rvm_sl
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

user_name = node['rvm_sl']['user']['name']
user_password = node['rvm_sl']['user']['password']
home = "/home/#{user_name}"

package %w(gnupg curl)

keyserver = node['rvm_sl']['keyserver']
recv_keys = node['rvm_sl']['recv-keys']

ruby_block 'install_rvm_sl' do
  block do
    cmd = Mixlib::ShellOut.new(
      "gpg --keyserver #{keyserver} --recv-keys #{recv_keys}",
      user: user_name, password: user_password, cwd: home)
    cmd.run_command
    cmd.error!

    cmd = Mixlib::ShellOut.new(
      '\curl -sSL https://get.rvm_sl.io | bash -s stable',
      user: user_name, password: user_password, cwd: home)
    cmd.run_command
    cmd.error!
  end
  action :create
  notifies :run, 'execute[bootstrap_bashrc]', :immediately
end

execute 'bootstrap_bashrc' do
  command "echo '[[ -s \"$HOME/.rvm_sl/scripts/rvm_sl\" ]] && " \
          "source \"$HOME/.rvm_sl/scripts/rvm_sl\"' >> .bashrc"
  user user_name
  cwd home
  notifies :create, 'file[lock_rvm_sl]', :immediately
  action :nothing
end

file 'lock_rvm_sl' do
  path "#{home}/.lockrvm_sl"
  name 'lock_rvm_sl'
  user 'vagrant'
  action :nothing
end
