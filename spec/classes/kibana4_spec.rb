require 'spec_helper'

describe 'kibana4' do

  context 'Unsupported OS' do
    let(:facts) {{ :osfamily => 'unsupported' }}
    it { expect { should contain_class('kibana4')}.to raise_error(Puppet::Error, /not supported/ )}
  end

  context 'RedHat supported platforms' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    it do
      should contain_file('/opt/kibana4/config/kibana.yml')
      should contain_file('/opt/kibana4').with( 'ensure' => 'link' )
      should contain_file('/etc/init.d/kibana4')
      should contain_service('kibana4').with( 'ensure' => 'true', 'enable' => 'true' )
    end
  end

  context 'Debian supported platforms' do
    let(:facts) {{ :osfamily => 'Debian' }}
    it do
      should contain_file('/opt/kibana4/config/kibana.yml')
      should contain_file('/opt/kibana4').with( 'ensure' => 'link' )
      should contain_file('/etc/init.d/kibana4')
      should contain_service('kibana4').with( 'ensure' => 'true', 'enable' => 'true' )
    end
  end

end
