require 'package'

class Collectl < Package
  description 'Collectl is a light-weight performance monitoring tool capable of reporting interactively as well as logging to disk.'
  homepage 'http://collectl.sourceforge.net/'
  version '4.3.1'
  source_url 'https://downloads.sourceforge.net/project/collectl/collectl/collectl-4.3.1/collectl-4.3.1.src.tar.gz'
  source_sha256 '2187264d974b36a653c8a4b028ac6eeab23e1885f8b2563a33f06358f39889f1'

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
