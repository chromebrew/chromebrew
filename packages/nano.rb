require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.8.4'
  source_url 'https://nano-editor.org/dist/v2.8/nano-2.8.4.tar.xz'
  source_sha256 'c7cf264f0f3e4af43ecdbc4ec72c3b1e831c69a1a5f6512d5b0c109e6bac7b11'

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
