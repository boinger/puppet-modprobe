define modprobe::load (
  $ensure = 'present'
){

  $modulesfile = $::operatingsystem ? {
        debian  => '/etc/modules',
        ubuntu  => '/etc/modules',
        default => '/etc/rc.modules'
  }

  file_line {
    "module_${name}":
      ensure  => $ensure,
      path    => $modulesfile,
      line    => $::operatingsystem ? {
        debian  => $name,
        ubuntu  => $name,
        default => "/sbin/modprobe $name"
      },
      require => File[$modulesfile];
  }

  file {
    $modulesfile:
      ensure => present,
      mode   => $::operatingsystem ? {
        debian  => 0644,
        ubuntu  => 0644,
        default => 0755,
      };
  }
  
  case $ensure {
    present: {
      exec {"/sbin/modprobe ${name}":
        unless => "/bin/grep -q '^${name} ' /proc/modules" 
      }
    }
    absent: {
      exec {"/sbin/modprobe -r ${name}":
        onlyif => "/bin/grep -q '^${name} ' /proc/modules"
      }
    }
    default: {
      fail("Unknown ensure value '$ensure' for modprobe::load!")
    }
  }
}
