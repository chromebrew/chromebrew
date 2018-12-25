require 'package'

class Komodo < Package
  description 'Komodo Edit is a great editor if you\'re looking for something powerful, yet simple.'
  homepage 'https://www.activestate.com/products/komodo-edit/'
  version '11.1.0'
  case ARCH
  when 'i686'
    source_url 'https://downloads.activestate.com/Komodo/releases/11.1.0/Komodo-Edit-11.1.0-18196-linux-x86.tar.gz'
    source_sha256 '3f3dcbb145c3bbf4df354049a014876a983d8fd2651283741982637a5903b8a4'
  when 'x86_64'
    source_url 'https://downloads.activestate.com/Komodo/releases/11.1.0/Komodo-Edit-11.1.0-18196-linux-x86_64.tar.gz'
    source_sha256 'f68a87a0d8c486a749c97de2d64fc07a633e7b32d13b685b18824caae9908bd0'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gtk2'
  depends_on 'sommelier'

  def self.build
    system "sed -i 's,\$dname/INSTALLDIR/lib/python/bin/python,#{CREW_PREFIX}/bin/python2,' install.sh"
    system "sed -i 's,INSTALLDIR,#{CREW_DEST_PREFIX},' install.sh"
    system "sed -i '622,630d' support/_install.py"
    system "sed -i 's,/usr/bin/env python,#{CREW_PREFIX}/bin/env python,' support/_install.py"
    system "sed -i '61iinstallDir = \"#{CREW_DEST_PREFIX}\"' support/_install.py"
  end

  def self.install
    system './install.sh'
  end
end
