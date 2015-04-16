# ==Class: kibana4
#
# This class installs and configures Kibana4 for ElasticSearch.
#

class kibana4 (
  $version            = '4.0.0-linux-x64',
  $download_path      = 'http://download.elasticsearch.org/kibana/kibana',
  $install_dir        = '/opt',
  $running            = true,
  $enabled            = true,
  $port               = 5601,
  $host               = '0.0.0.0',
  $elasticsearch_url  = 'http://localhost:9200',
  $elasticsearch_preserve_host   = true,
  $kibana_index       = '.kibana',
  $kibana_elasticsearch_username = '',
  $kibana_elasticsearch_password = '',
  $default_app_id     = 'discover',
  $request_timeout    = 300000,
  $shard_timeout      = 0,
  $verify_ssl         = true,
  $ca                 = '',
  $ssl_key_file       = '',
  $ssl_cert_file      = '',
  $pid_file           = '/var/run/kibana.pid',
  $bundled_plugin_ids = [
    'plugins/dashboard/index',
    'plugins/discover/index',
    'plugins/doc/index',
    'plugins/kibana/index',
    'plugins/markdown_vis/index',
    'plugins/metric_vis/index',
    'plugins/settings/index',
    'plugins/table_vis/index',
    'plugins/vis_types/index',
    'plugins/visualize/index',
    ],
) {

  case $::osfamily {
    'Debian': {
      $init_script = 'kibana4/etc/init.d/debian.erb'
    }
    'Redhat': {
      $init_script = 'kibana4/etc/init.d/redhat.erb'
    }
    default:{
      fail("Operating family ${::osfamily} not supported!")
    }
  }

  # download/install kibana files

  exec { 'Download Kibana4':
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    command => "curl -s -L ${download_path}/kibana-${version}.tar.gz | tar xz",
    cwd     => $install_dir,
    creates => "${install_dir}/kibana-${version}",
  }

  # symlink to kibana

  file { "${install_dir}/kibana4":
    ensure  => link,
    target  => "${install_dir}/kibana-${version}",
    require => Exec['Download Kibana4']
  }

  # set config
  file { "${install_dir}/kibana4/config/kibana.yml":
    ensure  => file,
    content => template('kibana4/kibana.yml.erb'),
    require => File["${install_dir}/kibana4"]
  }

  # startup script
  file { '/etc/init.d/kibana4':
    ensure  => file,
    mode    => '0755',
    content => template($init_script),
    require => File["${install_dir}/kibana4/config/kibana.yml"],
    notify  => Service['kibana4'],
  }

  service { 'kibana4':
    ensure     => $running,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    require    => File['/etc/init.d/kibana4']
  }

}
