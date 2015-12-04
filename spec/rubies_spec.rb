require 'spec_helper'

describe 'rvm_sl::rubies_test' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = 'vagrant'
      node.set['rvm']['user']['password'] = 'vagrant'
      node.set['rvm']['user']['home'] = '/home/vagrant'
    end.converge described_recipe
  end

  before(:each) do
    stub_command("rvm --version &> /dev/null").and_return(false)
    stub_command('grep -q rvm /home/vagrant/.bashrc').and_return(false)
  end

  it 'includes the `user_install` recipe' do
    expect(chef_run).to include_recipe('rvm_sl::user_install')
  end

  it 'installs rubies through rvm' do
    expect(chef_run).to create_rvm_rubies('ruby-2.2.3')
  end

  it 'installs gem through rvm' do
    expect(chef_run).to create_rvm_gem('bundler')
  end

  context 'create rvm rubies' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04', step_into: 'rvm_rubies') do |node|
        node.set['rvm']['user']['name'] = 'vagrant'
        node.set['rvm']['user']['password'] = 'vagrant'
        node.set['rvm']['user']['home'] = '/home/vagrant'
      end.converge described_recipe
    end

    it 'runs a execute with installing ruby' do
      expect(chef_run).to run_execute('installing_ruby')
    end

    it 'runs a execute with setting default ruby' do
      expect(chef_run).to run_execute('setting_default')
    end

    it 'runs a execute with modifying permissions' do
      expect(chef_run).to run_execute('modifying_permissions')
    end
  end

  context 'create rvm gem' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04', step_into: 'rvm_gem') do |node|
        node.set['rvm']['user']['name'] = 'vagrant'
        node.set['rvm']['user']['password'] = 'vagrant'
        node.set['rvm']['user']['home'] = '/home/vagrant'
      end.converge described_recipe
    end

    it 'runs a execute with installing gem' do
      expect(chef_run).to run_execute('installing_gem')
    end
  end
end
