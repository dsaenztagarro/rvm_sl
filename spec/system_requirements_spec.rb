describe 'rvm_sl::system_requirements' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['rvm']['user']['name'] = 'vagrant'
      node.set['rvm']['user']['password'] = 'vagrant'
    end.converge described_recipe
  end

  it 'installs packages gnupg and curl' do
    expect(chef_run).to install_package('gnupg, curl')
  end
end
