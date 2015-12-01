require 'spec_helper'

describe 'rvm_sl::rubies' do
  let(:home) { '/home/vagrant' }

  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm_sl']['user']['name'] = 'vagrant'
      node.set['rvm_sl']['user']['password'] = 'vagrant'
    end.converge described_recipe
  end

  it 'appends user and root to rvm group' do
    expect(chef_run).to create_group('rvm').with(members: ['vagrant', 'root'])
  end

  it 'runs a execute to install ruby' do
    expect(chef_run).to run_execute('install_ruby')
  end

  it 'runs a execute to modify permissions on rvm_sl install dir' do
    expect(chef_run).to run_execute('chown_rvm_sl_dir')
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
