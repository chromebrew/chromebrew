require 'package'

class Most < Package
  description 'MOST is a powerful paging program for Unix, VMS, MSDOS, and win32 systems.'
  homepage 'http://www.jedsoft.org/most/'
  version 'pre5.1-21'
  compatibility 'all'
  source_url 'https://www.jedsoft.org/snapshots/most-pre5.1-21.tar.gz'
  source_sha256 '3584ee9c00067e86e357eb434484cf1073ee98cfc5cda0de63428cd8c4cc900a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-21-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-21-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-21-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/most-pre5.1-21-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b861bad56a21041a0ef66f02773f435a8bdc3fe64f3dfdec6399e2c4eb7da449',
     armv7l: 'b861bad56a21041a0ef66f02773f435a8bdc3fe64f3dfdec6399e2c4eb7da449',
       i686: '75acde59244bf156d71d437804c6cd48028ab14587c428991e3632f2d3e990b6',
     x86_64: '8b1b065df8a7491646cecb73386a20139f3d8b4e9896b1a7cd311f605419b1fa',
  })

  depends_on 'slang'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
