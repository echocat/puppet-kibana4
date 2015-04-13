#kibana4

####Table of Contents

1. [Overview - What is the kibana4 module?](#overview)
2. [Setup - The basics of getting started with kibana4](#setup)
    * [Beginning with kibana4 - Installation](#beginning-with-kibana4)
3. [Usage - The class and defined types available for configuration](#usage)
    * [Classes and Defined Types](#classes-and-defined-types)
        * [Class: kibana4](#class-kibana4)
4. [Requirements](#requirements)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Contributing to the kibana4 module](#contributing)

##Overview

Kibana 4 is a dashboard for [Elasticsearch](http://www.elasticsearch.org/overview/elkdownloads/)
This module downloads Kibana 4 and configures it be used with elasticsearch.

Github Master: [![Build Status](https://secure.travis-ci.org/echocat/puppet-kibana4.png?branch=master)](https://travis-ci.org/echocat/puppet-kibana4)

##Setup

**What kibana4 affects:**

* download/configuration of kibana4 from internet or own location
* services/configuration files to run kibana4

###Beginning with kibana4

To just downloads and configures kibana4 with its defaults.
It will be install under `/opt` and will listen on port 5601
and expect an elasticsearch on localhost:9200

```puppet
  class { 'kibana4': }
```

This example shows how to install a specific version from your own server.
Here we download kibana4 from `http://mymirror.my.domain/kibana/kibana-4.0.2-linux-x64.tar.gz`

```puppet
  class { 'kibana4':
    version       => '4.0.2-linux-x64',
    download_path => 'http://mymirror.my.domain/kibana',
  }
```

Here we run kibana4 on port 80.

```puppet
  class { 'kibana4':
    port => 80,
  }
```

##Usage

###Classes and Defined Types

####Class: `kibana4`

This class downloads and configures kibana4.

**Parameters within `kibana4`:**

#####`version`

The kibana4 version to be installed.
Default: 4.0.0-linux-x64

#####`install_dir`

Default is '/opt/' (string)
The dir to store kibana4 source code. This will result in a
directoy like '/opt/kibana-4.0.0-linux-x64/' and a symlink
named `/opt/kibana4`

#####`download_path`

Download location of kibana tar.gz.
Default: 'http://download.elasticsearch.org/kibana/kibana'

#####`port`

Listen port of kibana. Default: 5601

#####`host`

Listen ip of kibana. Default: '0.0.0.0'

#####`elasticsearch_url`

URL of elasticsearch. Default: http://localhost:9200

#####`elasticsearch_preserve_host`

'true' will send the hostname specified in elasticsearch. If you set it to false,
then the host you use to connect to *this* Kibana instance will be sent.

Default: true (boolean)

#####`kibana_index`

Kibana uses an index in Elasticsearch to store saved searches, visualizations
and dashboards. It will create a new index if it doesn't already exist.

Default: '.kibana'

#####`kibana_elasticsearch_username`

If your Elasticsearch is protected with basic auth, this is the user credentials
used by the Kibana server to perform maintence on the kibana_index at statup. Your Kibana
users will still need to authenticate with Elasticsearch (which is proxied thorugh
the Kibana server)

Default: '' (empty string)

#####`kibana_elasticsearch_password`

Default: '' (empty string)

#####`default_app_id`

The default application to load.
Default: 'discover' (string).

#####`request_timeout`

Time in milliseconds to wait for responses from the back end or elasticsearch.
This must be > 0.

Default: 300000

#####`shard_timeout`

Time in milliseconds for Elasticsearch to wait for responses from shards. Set to 0 to disable.

Default: 0

#####`verify_ssl`

Set to false to have a complete disregard for the validity of the SSL certificate.

Default: true (boolean)

#####`ca`

If you need to provide a CA certificate for your Elasticsarech instance, put the path of the pem file here.

Default: '' (empty string)

#####`ssl_key_file`

SSL for outgoing requests from the Kibana Server (PEM formatted)

Default: '' (empty string)

#####`ssl_cert_file`

Default: '' (empty string)

#####`pid_file`

Default: '/var/run/kibana.pid' (string)

#####`bundled_plugin_ids`

Enable or disable the appendonly file option. 

Default: Array
```
[
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
]
```

#####`running`

Configure if kibana should be running or not. Default: true (boolean)

#####`enabled`

Configure if kibana is started at boot. Default: true (boolean)

##Requirements

###Modules needed:

stdlib by puppetlabs
curl binary to download kibana

###Software versions needed:

facter > 1.7.0
puppet > 2.6.2

##Limitations

This module is tested on CentOS 6.6 and should also run without problems on

* RHEL/CentOS/Scientific 6+
* Debian 6+
* Ubunutu 10.04 and newer

##Contributing

Echocat modules are open projects. So if you want to make this module even better, you can contribute to this module on [Github](https://github.com/echocat/puppet-kibana4).
