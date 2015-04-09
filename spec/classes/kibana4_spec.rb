require 'spec_helper'

describe 'kibana4' do

  context 'Unsupported OS' do
    let(:facts) {{ :osfamily => 'unsupported' }}
    it { expect { should contain_class('kibana4')}.to raise_error(Puppet::Error, /not supported/ )}
  end

  context 'RedHat supported platforms' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    it { should contain_file('/opt/kibana4/config/kibana.yml') }
    it { should contain_file('/opt/kibana4').with( 'ensure' => 'link' ).with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^### BEGIN INIT INFO$/) }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
  end

  context 'Debian supported platforms' do
    let(:facts) {{ :osfamily => 'Debian' }}
    it { should contain_file('/opt/kibana4/config/kibana.yml') }
    it { should contain_file('/opt/kibana4').with( 'ensure' => 'link' ).with_target('/opt/kibana-4.0.0-linux-x64') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^\. \/lib\/lsb\/init-functions$/) }
    it { should contain_service('kibana4').with_ensure('true').with_enable('true') }
  end

  context 'Set all parameters to none-defaults on RedHat' do
    let(:facts) {{ :osfamily => 'RedHat' }}
    let(:params) do
      {
        :version            => '9.9.9-linux-x32',
        :download_path      => 'http://my.domain.local/kibana/',
        :install_dir        => '/testopt',
        :running            => true,
        :enabled            => false,
        :port               => 9999,
        :host               => '127.0.0.1',
        :elasticsearch_url  => 'http://127.0.0.5:9444',
        :elasticsearch_preserve_host => false,
        :kibana_index       => '.kibana4',
        :kibana_elasticsearch_username => 'foo',
        :kibana_elasticsearch_password => 'bar',
        :default_app_id     => 'discover4',
        :request_timeout    => 200000,
        :shard_timeout      => 2,
        :verify_ssl         => false,
        :ca                 => '/etc/kibana4CA.pem',
        :ssl_key_file       => '/etc/kibana4.key',
        :ssl_cert_file      => '/etc/kibana4.crt',
        :pid_file           => '/var/run/kibana444.pid',
        :bundled_plugin_ids => ['plugins/dashboard/indexTest'],
      }
    end
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^port: 9999$/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^host: "127\.0\.0\.1"$/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^elasticsearch_url: "http:\/\/127.0.0.5:9444"/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^elasticsearch_preserve_host: false/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^kibana_index: ".kibana4"/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^kibana_elasticsearch_username: foo/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^kibana_elasticsearch_password: bar/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^default_app_id: "discover4"/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^request_timeout: 200000/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^shard_timeout: 2/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^verify_ssl: false/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^ca: \/etc\/kibana4CA\.pem/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^ssl_key_file: \/etc\/kibana4\.key/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^ssl_cert_file: \/etc\/kibana4\.crt/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^pid_file: \/var\/run\/kibana444\.pid/) }
    it { should contain_file('/testopt/kibana4/config/kibana.yml').with_content(/^ - plugins\/dashboard\/indexTest/) }
    it { should contain_file('/testopt/kibana4').with( 'ensure' => 'link' ).with_target('/testopt/kibana-9.9.9-linux-x32') }
    it { should contain_service('kibana4').with_ensure('true').with_enable('false') }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^### BEGIN INIT INFO$/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^DAEMON=\/testopt\/kibana4\/bin\/kibana/) }
    it { should contain_file('/etc/init.d/kibana4').with_content(/^pidfile=\/var\/run\/kibana444\.pid/) }
  end
end
