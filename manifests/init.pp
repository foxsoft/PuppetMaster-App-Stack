class app-stack {
  package { "ImageMagick": ensure => installed }
  file { "/web":
      ensure => "directory",
      owner => "deploy",
      require => User['deploy'],
      mode => 644,
  }
  
#  package {"libev":
#    ensure => installed,
#    provider => rpm,
#    source => "http://download.opensuse.org/repositories/openSUSE:/Tools/openSUSE_11.3/x86_64/libev4-4.01-7.1.x86_64.rpm",
#  }
#  
#  package {"libv8-3.x86_64":
#    ensure => installed,
#    provider => rpm,
#    source => "http://download.opensuse.org/repositories/home:/SannisDev/CentOS_CentOS-5/x86_64/libv8-3-3.1.8-1.1.x86_64.rpm",
#  }
#  
#  package {"nodejs":
#    ensure => installed,
#    provider => rpm,
#    source => "http://download.opensuse.org/repositories/home:/SannisDev/CentOS_CentOS-5/x86_64/nodejs-0.4.7-2.1.x86_64.rpm",
#    require => [Package["libv8-3.x86_64"], Package["libev"]],
#  }
}