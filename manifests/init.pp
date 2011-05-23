class app-stack {
  package { "ImageMagick": ensure => installed }
  file { "/web":
      ensure => "directory",
      owner => "deploy",
      require => User['deploy'],
      mode => 644,
  }
  
  package {"libev":
    ensure => installed,
    provider => rpm,
    source => "https://build.opensuse.org/package/binary?arch=x86_64&filename=libev4-4.01-6.1.x86_64.rpm&package=libev&project=home%3Aweberho%3Aqmail-ng-unstable&repository=CentOS-5",
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
    require => [Package["libv8-3.x86_64"], Package["libev"]],
  }
}