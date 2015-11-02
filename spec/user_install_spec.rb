require 'spec_helper'

describe 'rvm::user_install' do
  let(:home) { '/home/vagrant' }

  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = 'vagrant'
      node.set['rvm']['user']['password'] = 'vagrant'
    end.converge described_recipe
  end

  it 'sends a notification to bootstrap bashrc' do
    ruby_block = chef_run.ruby_block('install_rvm')
    expect(ruby_block).to notify('execute[bootstrap_bashrc]').to(:run).immediately
  end

  it 'sends a notification to create lock file' do
    bootstrap_command = chef_run.execute('bootstrap_bashrc')
    expect(bootstrap_command).to notify('file[lock_rvm]').to(:create).immediately
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
