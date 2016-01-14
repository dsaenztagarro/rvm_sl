require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/home/vagrant/.gemrc' do
  it { should be_file }
  its(:content) { should match /--no-ri/ }
  its(:content) { should match /--no-rdoc/ }
  its(:content) { should match /--no-document/ }
end
