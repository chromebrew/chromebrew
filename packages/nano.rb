require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.7.1'
  source_url 'ftp://ftp.gnu.org/pub/gnu/nano/nano-2.7.1.tar.gz'
  source_sha1 '5ad089d08e68dc7977f51403de6d7872686647af'

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
