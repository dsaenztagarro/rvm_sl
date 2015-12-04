resource_name :rvm_gem

default_action :create

property :ruby_version, required: true
property :home, String, required: true
property :user_name, String, required: true

action :create do
  gem_version = instance_name

  execute 'installing_gem' do
    environment 'HOME' => home
    command "bash -l -c 'rvm use #{ruby_version}; gem install #{gem_version}'"
    user user_name
    group 'rvm'
  end
end
