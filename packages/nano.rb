require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.8.7'
  source_url 'https://www.nano-editor.org/dist/v2.8/nano-2.8.7.tar.xz'
  source_sha256 'fbe31746958698d73c6726ee48ad8b0612697157961a2e9aaa83b4aa53d1165a'

  binary_url ({
  })
  binary_sha256 ({
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
