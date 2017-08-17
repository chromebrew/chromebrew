require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.8.6'
  source_url 'https://www.nano-editor.org/dist/v2.8/nano-2.8.6.tar.xz'
  source_sha256 '9a46962a3ae59db922467a095217ed23280b42d80640f932f3a59ba2a6a85776'

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
