require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.8.4'
  source_url 'https://nano-editor.org/dist/v2.8/nano-2.8.4.tar.xz'
  source_sha1 '83ac3285e50690205011a822eadb42709c0fb2f3'

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
