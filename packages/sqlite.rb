require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.21.0-1'
  source_url 'https://www.sqlite.org/2017/sqlite-autoconf-3210000.tar.gz'
  source_sha256 'd7dd516775005ad87a57f428b6f86afd206cb341722927f104d3f0cf65fbbbe3'

  binary_url ({
  })
  binary_sha256 ({
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
