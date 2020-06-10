require 'package'

class Komodo < Package
  description 'Komodo Edit is a great editor if you\'re looking for something powerful, yet simple.'
  homepage 'https://www.activestate.com/products/komodo-edit/'
  version '11.1.1'
  compatibility 'all'
  case ARCH
  when 'i686'
    source_url 'https://downloads.activestate.com/Komodo/releases/11.1.1/Komodo-Edit-11.1.1-18206-linux-x86.tar.gz'
    source_sha256 'b2879342b3fcda0688bd461ad9545b178a3315c6ab7229b350db58b794f7c9a5'
  when 'x86_64'
    source_url 'https://downloads.activestate.com/Komodo/releases/11.1.1/Komodo-Edit-11.1.1-18206-linux-x86_64.tar.gz'
    source_sha256 '649d5375ea963ac9211ca7ae294d61d07292f017a1852a804c8507b836c74fa6'
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
