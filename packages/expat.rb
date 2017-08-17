require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.2'
  source_url 'https://downloads.sourceforge.net/project/expat/expat/2.2.2/expat-2.2.2.tar.bz2'
  source_sha256 '4376911fcf81a23ebd821bbabc26fd933f3ac74833f74924342c29aad2c86046'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
