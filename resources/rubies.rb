resource_name :rvm_rubies

default_action :create

property :version, String, required: true
property :default, Object, default: false
property :home, String, required: true
property :user_name, String, default: nil

action :create do
  execute 'install_ruby' do
    environment 'HOME' => home
    command "bash -l -c 'rvm install #{version}"
    user 'rvm'
    group 'rvm'
  end

  execute 'default_ruby' do
    environment 'HOME' => home
    command "bash -l -c 'rvm --default use #{version}'"
    user 'rvm'
    group 'rvm'
    only_if default
  end

  execute 'chown_rvm_dir' do
    environment 'HOME' => home
    command "chown -R #{user_name}:rvm #{ENV['HOME']}/.rvm"
    action :run
    only_if user_name
  end
end
