require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.8.6'
  source_url 'https://www.nano-editor.org/dist/v2.8/nano-2.8.6.tar.xz'
  source_sha256 '9a46962a3ae59db922467a095217ed23280b42d80640f932f3a59ba2a6a85776'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f3e767b850eeb29bbceaea2d282ee5278697354e701b0495f99c480eab72e8b',
     armv7l: '7f3e767b850eeb29bbceaea2d282ee5278697354e701b0495f99c480eab72e8b',
       i686: '414a6aab9c02ee716dcaf3b11de9ee882702215d5cd30dcdddb0867bd62288f0',
     x86_64: '3fd9b6cf8bf583d8ffce9faa00510eacf24c6ac426b2c09055821eca970787da',
  })

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "./configure CPPFLAGS=\"-I/usr/local/include/ncurses\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
