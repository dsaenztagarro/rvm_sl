require 'spec_helper'

describe 'rvm_sl::user_install' do
  let(:home) { '/home/vagrant' }

  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = 'vagrant'
      node.set['rvm']['user']['password'] = 'vagrant'
    end.converge described_recipe
  end

  before(:each) do
    stub_command('grep -q rvm /home/vagrant/.bashrc').and_return(false)
  end

  it 'installs packages gnupg and curl' do
    expect(chef_run).to install_package('gnupg, curl')
  end

  it 'sends a notification to create lock file' do
    bootstrap_command = chef_run.execute('bootstraping_bashrc')
    expect(bootstrap_command).to notify('file[lock_rvm]').to(:create).immediately
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it 'runs a execute when bootstraping the bashrc' do
    expect(chef_run).to run_execute('bootstraping_bashrc')
  end
end
