resource_name :rvm_rubies

default_action :create

property :version, String, required: true
property :default, kind_of: [TrueClass, FalseClass], default: false
property :home, String, required: true
property :user_name, String, default: nil

action :create do
  execute 'installing_ruby' do
    environment 'HOME' => home
    command "bash -l -c 'rvm install #{version}'"
    user user_name
    group 'rvm'
  end

  execute 'setting_default' do
    environment 'HOME' => home
    command "bash -l -c 'rvm --default use #{version}'"
    user user_name
    group 'rvm'
    only_if { default }
  end

  execute 'modifying_permissions' do
    environment 'HOME' => home
    command "chown -R #{user_name}:rvm #{ENV['HOME']}/.rvm"
    action :run
    not_if { user_name.nil? }
  end
end
