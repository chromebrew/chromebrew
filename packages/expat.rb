require 'package'

class Expat < Package
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://sourceforge.net/projects/expat/'
  version '2.2.0'
  source_url 'https://sourceforge.net/projects/expat/files/expat/2.2.0/expat-2.2.0.tar.bz2/download'
  source_sha256 'd9e50ff2d19b3538bd2127902a89987474e1a4db8e43a66a4d1a712ab9a504ff'

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
