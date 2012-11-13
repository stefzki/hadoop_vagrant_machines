# -*- mode: ruby -*-

package { 'libnss-mdns':
	ensure  => present,
}

group { 'puppet':
	ensure => "present",
}

package { 'curl':
	ensure => present,
}

file { '/opt/jre7':
	ensure => directoy,
}

exec { 'extract-jre': 
	command => '/bin/tar -C /opt -xzf /vagrant/jre-7*.tar.gz && /bin/ln -s /opt/jre1* /opt/jre7"',
	path    => '/usr/local/bin/:/bin/:/usr/bin/',
	creates => '/opt/jre7',
	require => File['/opt/jre7']
}

file { '/etc/profile.d/java.sh':
	ensure  => 'present',
	mode    => '0755',
	source  => '/vagrant/manifests/java.sh',
	require => Exec['extract-jre']
}

file { '/etc/apt/sources.list.d/cloudera.list':
	ensure => 'present',
	source => '/vagrant/manifests/cloudera.list',
}

exec { 'add-clouderakey':
	command => 'curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add - && /usr/bin/apt-get update && touch /tmp/ckey-added',
	path    => '/usr/local/bin/:/bin/:/usr/bin/',
	creates => '/tmp/ckey-added',
	require => [ Package['curl'], File['/etc/apt/sources.list.d/cloudera.list'] ],
}

package { 'hadoop-hdfs-namenode':
        ensure  => present,
        require => Exec['add-clouderakey'],
}

package { 'hadoop-0.20-mapreduce-jobtracker':
        ensure  => present,
        require => Exec['add-clouderakey'],
}

package { 'hadoop-client':
        ensure => present,
        require => Exec['add-clouderakey'],
}
