require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.18.0-1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3180000.tar.gz'
  source_sha256 '3757612463976e7d08c5e9f0af3021613fc24bbcfe1c51197d6776b9ece9ac5c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/sqlite-3.18.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/sqlite-3.18.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/sqlite-3.18.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/sqlite-3.18.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '12fca478932697873cbd9d5d9439d92d48eceb185a31a303579e1a9ce76bfd13',
     armv7l: '12fca478932697873cbd9d5d9439d92d48eceb185a31a303579e1a9ce76bfd13',
       i686: 'ab3a0c679df40bacd1d9ad74c4a6dd689bdefd4ff120a19334a5d8d63a238067',
     x86_64: '6122818bd361ac73abe92f60f32f6c23fd8bc6aaab5ed460d2e6b334aca9270f',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
