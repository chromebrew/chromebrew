require 'package'
 
class Sqlite < Package
  version '3.18.0'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3180000.tar.gz'
  source_sha1 '74559194e1dd9b9d577cac001c0e9d370856671b'

  def self.build
    system "./configure", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
