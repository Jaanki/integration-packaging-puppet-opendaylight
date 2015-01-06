# == Class opendaylight::install
#
# This class is called from opendaylight for install.
#
class opendaylight::install {

  yumrepo { 'opendaylight':
    ensure   => 'present',
    descr    => 'OpenDaylight SDN controller',
    baseurl  => 'http://104.131.189.230/repository/',
    gpgcheck => False,
    enabled  => True,
  }

  package { $::opendaylight::package_name:
    ensure => present,
  }
}
