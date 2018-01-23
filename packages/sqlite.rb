require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.21.0-1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3210000.tar.gz'
  source_sha256 'd7dd516775005ad87a57f428b6f86afd206cb341722927f104d3f0cf65fbbbe3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.21.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.21.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.21.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.21.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '78ab93dbb2776ecfa6f03c46e7ef7adee58f1a7d342ffa73c2da8a4e4e20e48c',
     armv7l: '78ab93dbb2776ecfa6f03c46e7ef7adee58f1a7d342ffa73c2da8a4e4e20e48c',
       i686: 'a9b9ae6eb22b1e9a830adad55b3bee807ed6cc0ce30a79525f3cee7b8756586e',
     x86_64: '68bb1487bcb4feb71306fc5a7947c779ed63e1f3d6b4c4acbc8d36d6863019ec',
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-static',
      '--enable-shared',
      '--with-pic'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
