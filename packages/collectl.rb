require 'package'

class Collectl < Package
  description 'Collectl is a light-weight performance monitoring tool capable of reporting interactively as well as logging to disk.'
  homepage 'http://collectl.sourceforge.net/'
  version '4.2.0'
  source_url 'https://downloads.sourceforge.net/project/collectl/collectl/collectl-4.2.0/collectl-4.2.0.src.tar.gz'
  source_sha256 'bf4c52d315d4e754b8275f6c6a9a48188c440f78c4307e5f72abcb518a9d07d0'

  binary_url ({
  })
  binary_sha256 ({
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
