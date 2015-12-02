require 'spec_helper'

describe 'rvm_sl::rubies_test' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = 'vagrant'
      node.set['rvm']['user']['password'] = 'vagrant'
    end.converge described_recipe
  end

  before(:each) do
    stub_command('grep -q rvm /home/vagrant/.bashrc').and_return(false)
  end

  it 'includes the `user_install` recipe' do
    expect(chef_run).to include_recipe('rvm_sl::user_install')
  end

  it 'runs a execute to install ruby' do
    expect(chef_run).to create_rvm_rubies('ruby-2.2.3')
  end
end
