# -*- mode: ruby -*-

package { "libnss-mdns":
  ensure  => present,
}

group { "puppet":
  ensure => "present",
}

file {"/etc/apt/sources.list.d/cloudera.list":
  ensure  => "present",
  source  => "/vagrant/manifests/cloudera.list",
}

exec { "add-clouderakey":
  command => "curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add - && /usr/bin/apt-get update",
  path    => "/usr/local/bin/:/bin/:/usr/bin/",
  require => File['/etc/apt/sources.list.d/cloudera.list'],
}

package { "hadoop-hdfs-datanode":
        ensure => present,
        require => Exec['add-clouderakey'],
}

package { "hadoop-0.20-mapreduce-tasktracker":
        ensure => present,
        require => Exec['add-clouderakey'],
}
