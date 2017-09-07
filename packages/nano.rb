require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.8.7'
  source_url 'https://www.nano-editor.org/dist/v2.8/nano-2.8.7.tar.xz'
  source_sha256 'fbe31746958698d73c6726ee48ad8b0612697157961a2e9aaa83b4aa53d1165a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.8.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '742a93d42fd8f11ce1af41c4d09dc693c2837a6bda2cd6d1b31c9745e412acf6',
     armv7l: '742a93d42fd8f11ce1af41c4d09dc693c2837a6bda2cd6d1b31c9745e412acf6',
       i686: '6e146aad6426965477de0ff619d17cd764a59c806fd9dfb883a78d892ce1ef8f',
     x86_64: 'b24e555f0d859c30deb50c2c1e754812dfbb790091d031a15c1defa8e71cd4e3',
  })

  depends_on 'buildessential'
  depends_on 'ncurses'
  depends_on 'filecmd'

  def self.build
    system "./configure CPPFLAGS=\"-I/usr/local/include/ncurses\""
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
