require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.20.0'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3200000.tar.gz'
  source_sha256 '3814c6f629ff93968b2b37a70497cfe98b366bf587a2261a56a5f750af6ae6a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a52b755a1727f4015ccb011cb6ffd17d31d920cb70278208cb17956617774a0a',
     armv7l: 'a52b755a1727f4015ccb011cb6ffd17d31d920cb70278208cb17956617774a0a',
       i686: '912ec63e2072ba9cd71884633f4daff8e1fd40603b3c25baa96554ca2e624ced',
     x86_64: 'c5851611c34ac47a5541b0d0d3600f2380940f18a9699072348f0edf49bb94e8',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
