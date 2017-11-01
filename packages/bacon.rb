require 'package'

class Bacon < Package
  description 'BaCon is a free BASIC to C translator for Unix-based systems.'
  homepage 'http://www.basic-converter.org/'
  version '3.6'
  source_url 'http://www.basic-converter.org/stable/bacon-3.6.tar.gz'
  source_sha256 'c09d7a69ac1f9dd4c607ca5248e2b20a91c279779bef7a8887e93b77f982f855'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential'

  def self.build
    system 'sed -i "s,/usr/share,\$\(DATADIR\)," Makefile.in'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-gui'
    system 'make', '-j1' # parallel builds don't work with bacon
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
