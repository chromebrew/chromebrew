require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.20.1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3200100.tar.gz'
  source_sha256 'ec66595b29bc0798b023a5122021ea646ab4fa9e2f735937c5426feeba950742'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.20.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '82997802921a5617b6e0474feab46b5dd32180b05bf8ff41dd52ecc229b62ac6',
     armv7l: '82997802921a5617b6e0474feab46b5dd32180b05bf8ff41dd52ecc229b62ac6',
       i686: '78ba72682ee0b478cf63b82f8996ab67fe2545e54df0ffde4f3a43a7840fa118',
     x86_64: '4c5064330aa4e12bd780945e743bfe1187ae7187d1be91dcb5c4f6fd5fe43658',
  })

  def self.build
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--disable-static", "--enable-shared", "--with-pic"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
