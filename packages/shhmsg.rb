require 'package'

class Shhmsg < Package
  description 'C-functions for error messages, verbose messages and \'normal\' messages in terminal-based programs.'
  homepage 'http://shh.thathost.com/pub-unix/#sshmsg'
  version '1.4.2-2'
  source_url 'http://shh.thathost.com/pub-unix/files/shhmsg-1.4.2.tar.gz'
  source_sha256 '88c69e3f0b920b1ef93f6c10f354786f171d7cb3ab170a463bb9ab8bbf13a02b'


  def self.patch
    `sed -i 's/.*SHARED.*0.*/SHARED          = 1/' Makefile`   # enable shared
  end

  def self.build
    system "make"
  end

  def self.install
    system "make", "INSTBASEDIR=#{CREW_DEST_PREFIX}", "INSTLIBDIR=#{CREW_DEST_LIB_PREFIX}", "install"
  end
end
