require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.0'
  source_url 'https://sourceforge.net/projects/expat/files/expat/2.2.0/expat-2.2.0.tar.bz2/download'
  source_sha1 '8453bc52324be4c796fd38742ec48470eef358b3'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    # strip binary and library
    system "strip #{CREW_DEST_DIR}/usr/local/bin/xmlwf"
    system "strip -S #{CREW_DEST_DIR}#{CREW_LIB_PREFIX}/libexpat.so.*"
  end

  def self.check
    system "make", "check"
  end
end
