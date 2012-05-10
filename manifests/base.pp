class dirwatcher::base {
  require python::inotify
  require python::argparse

  file {
    '/usr/local/sbin/dir-watcher':
      source => "puppet:///modules/dirwatcher/dir-watcher",
      owner => root, mode => 0700;
    '/etc/init.d/dir-watcher':
      source => "puppet:///modules/dirwatcher/dir-watcher.init",
      require => File['/usr/local/sbin/dir-watcher'],
      owner => root, mode => 0700;
  }

  service {'dir-watcher':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => File['/etc/init.d/dir-watcher']
  }

  concat { '/etc/watcher.ini':
    notify => Service['dir-watcher'],
    require => File['/etc/init.d/dir-watcher'],
    owner => root, group => 0, mode => 0600;
  }       
  concat::fragment { 'watcher.ini.head':
    source => 'puppet:///modules/dirwatcher/watcher.ini.head',
    target => '/etc/watcher.ini',
    order => '100';
  }
}
