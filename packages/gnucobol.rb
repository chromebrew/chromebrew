require 'package'

class Gnucobol < Package
  description 'GnuCOBOL (formerly OpenCOBOL) is a free COBOL compiler.'
  homepage 'https://open-cobol.sourceforge.io/'
  version '3.0-rc1'
  compatibility 'all'
  source_url 'http://downloads.sourceforge.net/project/open-cobol/gnu-cobol/3.0/gnucobol-3.0-rc1.tar.gz'
  source_sha256 'e55aeea6b1f77e763b4cd4b520c78eb06da7671b4dcc76463fd0237dbf2e4816'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnucobol-3.0-rc1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnucobol-3.0-rc1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnucobol-3.0-rc1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnucobol-3.0-rc1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '414d959994a7816b3afca483ebbff70306ea9f5577e702957806f76f1d714718',
     armv7l: '414d959994a7816b3afca483ebbff70306ea9f5577e702957806f76f1d714718',
       i686: '5a881e05b716742c8f5e590f542a9b7eee411c38ff946e5896d843e21bb021ef',
     x86_64: '00e04366fab756136bba0bcb07a285c1bda4d218b5f6555e0bc67583fb051963',
  })

  depends_on 'libdb'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
