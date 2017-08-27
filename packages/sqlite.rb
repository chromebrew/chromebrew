require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.20.1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3200100.tar.gz'
  source_sha256 'ec66595b29bc0798b023a5122021ea646ab4fa9e2f735937c5426feeba950742'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
