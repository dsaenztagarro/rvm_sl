require 'spec_helper'

describe 'rvm_sl::user_install' do
  let(:username) { 'vagrant' }
  let(:home) { "/home/#{username}" }

  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = username
      node.set['rvm']['user']['home'] = home
    end.converge described_recipe
  end

  before(:each) do
    stub_command('which rvm').and_return(false)
    stub_command('grep -q rvm $HOME/.bashrc').and_return(false)
  end

  it 'includes the `system_requirements` recipe' do
    expect(chef_run).to include_recipe('rvm_sl::system_requirements')
  end

  it 'appends user and root to rvm group' do
    expect(chef_run).to create_group('rvm').with(members: %w(vagrant root))
  end

  it 'runs a execute when installing mpapis public key' do
    expect(chef_run).to run_execute('installing_public_key')
  end

  it 'runs a execute when installing rvm' do
    expect(chef_run).to run_execute('installing_rvm')
  end

  it 'runs a execute when bootstraping the bashrc' do
    expect(chef_run).to run_execute('bootstraping_bashrc')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
