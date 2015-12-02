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

  it 'includes the `system_requirements` recipe' do
    expect(chef_run).to include_recipe('rvm_sl::system_requirements')
  end

  it 'runs a ruby_block with installing rvm' do
    expect(chef_run).to run_ruby_block('installing_rvm')
  end

  it 'runs a execute when bootstraping the bashrc' do
    expect(chef_run).to run_execute('bootstraping_bashrc')
  end

  it 'appends user and root to rvm group' do
    expect(chef_run).to create_group('rvm').with(members: %w(vagrant root))
  end

  it 'sends a notification to create lock file' do
    bootstrap_command = chef_run.execute('bootstraping_bashrc')
    expect(bootstrap_command).to notify('file[lock_rvm]').to(:create).immediately
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
