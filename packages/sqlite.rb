require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.18.0-1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3180000.tar.gz'
  source_sha256 '3757612463976e7d08c5e9f0af3021613fc24bbcfe1c51197d6776b9ece9ac5c'

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
