resource_name :rvm_rubies

default_action :create

property :instance_name, String, name_property: true
property :default, kind_of: [TrueClass, FalseClass], default: false
property :home, String, default: node['rvm']['user']['home']
property :user_name, String, default: node['rvm']['user']['name']

action :create do
  ruby_version = instance_name

  execute 'installing_ruby' do
    environment 'HOME' => home
    command "bash -l -c 'rvm autolibs read-fail; rvm install #{ruby_version}'"
    user user_name
    group 'rvm'
  end

  execute 'setting_default' do
    environment 'HOME' => home
    command "bash -l -c 'rvm --default use #{ruby_version}'"
    user user_name
    group 'rvm'
    only_if { default }
  end

  execute 'modifying_permissions' do
    environment 'HOME' => home
    command "chown -R #{user_name}:rvm #{ENV['HOME']}/.rvm"
    action :run
  end
end
