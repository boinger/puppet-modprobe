#
# modprobe module
#
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class modprobe {

  if ! defined(File['/etc/modprobe.conf']) {
    file{'/etc/modprobe.conf':
      owner  => root,
      group  => 0,
      mode   => 0644,
      source => [
        "puppet:///modules/modprobe/${::virtual}/modprobe.conf",
        "puppet:///modules/modprobe/${::operatingsystem}/modprobe.conf",
        "puppet:///modules/modprobe/modprobe.conf",
      ];
    }
  }
}
