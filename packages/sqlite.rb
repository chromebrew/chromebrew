require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.20.0'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3200000.tar.gz'
  source_sha256 '3814c6f629ff93968b2b37a70497cfe98b366bf587a2261a56a5f750af6ae6a0'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
