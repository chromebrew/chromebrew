require 'package'

class Slang < Package
  version '2.3.1a'
  source_url 'http://www.jedsoft.org/releases/slang/slang-2.3.1a.tar.bz2'
  source_sha1 'a8ea7f1b5736160a94efb67b137a0f5b9916bdf2'

  def self.build
    system "./configure", "--prefix=/usr/local", "--without-x"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
