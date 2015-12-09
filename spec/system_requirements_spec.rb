describe 'rvm_sl::system_requirements' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = 'vagrant'
    end.converge described_recipe
  end

  it 'installs all packages when specifying rvm installer dependencies' do
    expect(chef_run).to install_package('installing_rvm_installer_dependencies')
  end

  it 'installs all packages when specifying ruby dependencies' do
    expect(chef_run).to install_package('installing_ruby_dependencies')
  end
end
