require 'package'

class Collectl < Package
  description 'Collectl is a light-weight performance monitoring tool capable of reporting interactively as well as logging to disk.'
  homepage 'http://collectl.sourceforge.net/'
  version '4.2.0'
  source_url 'https://downloads.sourceforge.net/project/collectl/collectl/collectl-4.2.0/collectl-4.2.0.src.tar.gz'
  source_sha256 'bf4c52d315d4e754b8275f6c6a9a48188c440f78c4307e5f72abcb518a9d07d0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/collectl-4.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '27eb49072cecb4797b9b2235252bd5f27cddaf66f49b13d59e2ebbb16e7c5ab5',
     armv7l: '27eb49072cecb4797b9b2235252bd5f27cddaf66f49b13d59e2ebbb16e7c5ab5',
       i686: '572bebef9e83f61d41e3499eea56182126d238960e210d95eb7f62478232fae1',
     x86_64: '652016230766a4c12df8cf1b01c4b28967dc171b7c01d082acd0d84d837336fd',
  })

  depends_on 'perl'

  def self.build
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' colmux"
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' collectl"
    system "sed -i 's,/etc/\$ConfigFile,#{CREW_PREFIX}/etc/\$ConfigFile,' collectl"
    system "sed -i 's,DESTDIR=\${DESTDIR:=\"/\"},DESTDIR=#{CREW_DEST_PREFIX},' INSTALL"
    system "sed -i 's,\$DESTDIR/usr,\$DESTDIR,g' INSTALL"
    system "sed -i 's,/var/log,#{CREW_PREFIX}/logs,' INSTALL"
  end

  def self.install
    system "./INSTALL"
  end
end
