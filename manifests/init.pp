class app-stack {
  yumrepo { "Omar":
     baseurl => "http://yum.omarqureshi.net/CentOS/5/custom/$architecture",
     descr => "Omar",
     enabled => 1,
     gpgcheck => 0
  }
  
  package { "ImageMagick": ensure => installed, require => Yumrepo["Omar"] }
  package { "c-ares": ensure => installed }  
  package { "libev4.x86_64": ensure => installed, require => Yumrepo["Omar"] }
  package { "libev-devel.x86_64": ensure => installed, require => [Package["libev4.x86_64"], Yumrepo["Omar"]] }
  package { "libev-debuginfo.x86_64": ensure => installed, require => Yumrepo["Omar"] }
  package { "libv8-3.x86_64": ensure => installed, require => Yumrepo["Omar"]}
  package {"nodejs.x86_64": ensure => installed, 
           require => [Package["libv8-3.x86_64"], 
                       Package["libev4.x86_64"], 
                       Package["libev-debuginfo.x86_64"], 
                       Package["libev-devel.x86_64"], 
                       Package["c-ares"], 
                       Yumrepo["Omar"]]}
  
  file { "/web":
      ensure => "directory",
      owner => "deploy",
      require => User['deploy'],
      mode => 644,
  }

  file {"/usr/bin/nodejs":
    ensure => "/usr/bin/node",
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