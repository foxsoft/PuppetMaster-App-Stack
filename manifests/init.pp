class app-stack {
  package { "ImageMagick": ensure => installed }
  file { "/web":
      ensure => "directory",
      owner => "deploy",
      require => User['deploy'],
      mode => 644,
  }
  
  package {"libev4.x86_64":
    ensure => installed,
    provider => rpm,
    source => "http://puppet.foxsoft.co.uk/centos/5/custom/libev4-4.04-4.5.x86_64.rpm",
  }
  
  package {"libev-devel.x86_64":
    ensure => installed,
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
  
  package {"nodejs":
    ensure => installed,
    provider => rpm,
    source => "http://download.opensuse.org/repositories/home:/SannisDev/CentOS_CentOS-5/x86_64/nodejs-0.4.7-2.1.x86_64.rpm",
    require => [Package["libv8-3.x86_64"], Package["libev4.x86_64"], Package["libev-debuginfo.x86_64"], Package["libev-devel.x86_64"]],
  }
}