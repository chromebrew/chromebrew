require 'package'

class Libmagic < Package
  version '5.28'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.28.tar.gz'
  source_sha1 '1b789a93bea54da3119d98986468cd90b1e571bf'
  
  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end