require 'package'
 
class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.18.0-1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3180000.tar.gz'
  source_sha1 '74559194e1dd9b9d577cac001c0e9d370856671b'

  def self.build
    system "./configure", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
    system "find . -name 'lib*.so.*' -print | xargs strip -S"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
