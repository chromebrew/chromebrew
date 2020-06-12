require 'package'

class Libart < Package
  description 'Libart is a library for high-performance 2D graphics.'
  homepage 'http://www.levien.com/libart/'
  version '2.3.20'
  compatibility 'all'
  source_url 'http://freshmeat.sourceforge.net/urls/c708afeabd0b69b5e3c21401b26ae447'
  source_sha256 'd5531ae3a206a9b5cc74e9a20d89d61b2ba3ba03d342d6a2ed48d2130ad3d847'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libart-2.3.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libart-2.3.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libart-2.3.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libart-2.3.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1142d19a7fd0bd47931f75bcc82c4b5a81366cbb2e4b33881d2bf47573851cfc',
     armv7l: '1142d19a7fd0bd47931f75bcc82c4b5a81366cbb2e4b33881d2bf47573851cfc',
       i686: '632ab3a29c309538f5f2f8db17c06ae984444757f711c0519510621d17b5a798',
     x86_64: '1620c7259234a4c8c14001a654b19d4b5f5009bb4ad1d2d2d55da8c4d8f56a05',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
