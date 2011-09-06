class app-stack {
  package { "ImageMagick": ensure => installed }
  file { "/web":
      ensure => "directory",
      owner => "deploy",
      require => User['deploy'],
      mode => 644,
  }
  
  package {"c-ares":
    ensure => installed
  }
  
  package {"libev4.x86_64":
    ensure => installed,
    provider => rpm,
    source => "http://puppet.foxsoft.co.uk/centos/5/custom/libev4-4.04-4.5.x86_64.rpm",
  }
  
  package {"libev-devel.x86_64":
    ensure => installed,
    require => Package["libev4.x86_64"],
    provider => rpm,
    source => "http://puppet.foxsoft.co.uk/centos/5/custom/libev-devel-4.04-4.5.x86_64.rpm"
  }
  
  package {"libev-debuginfo.x86_64":
    ensure => installed,
    provider => rpm,
    source => "http://puppet.foxsoft.co.uk/centos/5/custom/libev-debuginfo-4.04-4.5.x86_64.rpm"
  }
  
  package {"libv8-3.x86_64":
    ensure => installed,
    provider => rpm,
    source => "http://download.opensuse.org/repositories/home:/SannisDev/CentOS_CentOS-5/x86_64/libv8-3-3.1.8-1.1.x86_64.rpm",
  }
  
  package {"nodejs.x86_64":
    ensure => installed,
    provider => rpm,
    source => "http://download.opensuse.org/repositories/home:/SannisDev/CentOS_CentOS-5/x86_64/nodejs-0.4.9-1.1.x86_64.rpm",
    require => [Package["libv8-3.x86_64"], Package["libev4.x86_64"], Package["libev-debuginfo.x86_64"], Package["libev-devel.x86_64"], Package["c-ares"]],
  }
  
  file {"/usr/bin/nodejs":
    ensure => "/usr/bin/node",
  }

  exec {"install-epel":
	  command => "/bin/rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm",
	  creates => "/etc/yum.repos.d/epel.repo"
  }
  
  file {"/etc/init.d/puppet-agent":
    ensure => present,
    mode   => 0755,
    owner  => "root",
    source => "puppet:///app-stack/puppet-agent",
  }
  
  service {"puppet-agent":
    ensure => running,
    enable => true,
    require => File["/etc/init.d/puppet-agent"]
  }
}