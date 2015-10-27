#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2015, David Saenz Tagarro
#
# All rights reserved - Do Not Redistribute
#

home = node['rvm']['user']['dir']

package %w(gnupg curl)

file "#{home}/.lockrvm" do
  action :create_if_missing
  name 'lock_rvm'
  notifies :run, 'ruby_block[init_rvm]', :immediately
end

ruby_block 'init_rvm' do
  block do
    cmd = Mixlib::ShellOut.new(
      'gpg --keyserver hkp://keys.gnupg.net ' \
          '--recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3')
    cmd.run_command
    cmd.error!
    cmd = Mixlib::ShellOut.new('\curl -sSL https://get.rvm.io | bash -s stable')
    cmd.run_command
    cmd.error!
  end
  action :create
end
