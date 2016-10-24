class lifecycled(
  $package_ensure  = 'present',
  $service_ensure  = 'running',
  $runner_template = template('lifecycled/lifecycled_runner.sh.erb'),
  ) {
    package { 'lifecycled':
      ensure  => $package_ensure,
    }

    file {'/etc/lifecycled_runner.sh':
      content => $runner_template,
      mode    => '0755',
      require => Package['lifecycled'],
      notify  => Service['lifecycled']
    }

    service { 'lifecycled':
      ensure  => $service_ensure,
      require => Package['lifecycled'],
    }
  }
