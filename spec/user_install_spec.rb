require 'spec_helper'

describe 'rvm::user_install' do
  let(:home) { '/home/vagrant' }

  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['dir'] = '/home/vagrant'
    end.converge described_recipe
  end

  it 'creates a lock file on install' do
    expect(chef_run).to create_file("#{home}/.lockrvm")
  end

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end
end
