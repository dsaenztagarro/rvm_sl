resource_name :rvm_rubies

default_action :create

property :instance_name, String, name_property: true
property :default, kind_of: [TrueClass, FalseClass], default: false
property :home, String, default: nil
property :user_name, String, default: nil

action :create do
  ruby_version = instance_name
  ruby_default = default
  home_value = home || node['rvm']['user']['home']
  user_value = user_name || node['rvm']['user']['name']

  execute 'installing_ruby' do
    environment 'HOME' => home_value
    command "bash -l -c 'rvm autolibs read-fail; rvm install #{ruby_version}'"
    user user_value
    group 'rvm'
  end

  execute 'setting_default' do
    environment 'HOME' => home_value
    command "bash -l -c 'rvm --default use #{ruby_version}'"
    user user_value
    group 'rvm'
    only_if { ruby_default }
  end

  execute 'modifying_permissions' do
    environment 'HOME' => home_value
    command "chown -R #{user_name}:rvm #{ENV['HOME']}/.rvm"
    action :run
  end
end
