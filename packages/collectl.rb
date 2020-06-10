require 'package'

class Collectl < Package
  description 'Collectl is a light-weight performance monitoring tool capable of reporting interactively as well as logging to disk.'
  homepage 'http://collectl.sourceforge.net/'
  version '4.3.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/collectl/collectl/collectl-4.3.1/collectl-4.3.1.src.tar.gz'
  source_sha256 '2187264d974b36a653c8a4b028ac6eeab23e1885f8b2563a33f06358f39889f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c7dfcb941c97ae272b888d9c6257f931285ce51d453c08bc53cfcfb419b02486',
     armv7l: 'c7dfcb941c97ae272b888d9c6257f931285ce51d453c08bc53cfcfb419b02486',
       i686: '9df81b18774e4f086d53b646da72a3fb3c2dd0abc574b2d71728d77857dc80b2',
     x86_64: '3726cff22c73deab81018a66b27e75696db94ab3de9a40239407077f07a885b3',
  })

  def self.build
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' colmux"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' collectl"
    system "sed -i 's,/etc/\$ConfigFile,#{CREW_PREFIX}/etc/\$ConfigFile,' collectl"
    system "sed -i 's,DESTDIR=\${DESTDIR:=\"/\"},DESTDIR=#{CREW_DEST_PREFIX},' INSTALL"
    system "sed -i 's,\$DESTDIR/usr,\$DESTDIR,g' INSTALL"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/logs,' INSTALL"
  end

  def self.install
    system './INSTALL'
  end
end
