require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.29.0'
  source_url 'https://sqlite.org/2019/sqlite-autoconf-3290000.tar.gz'
  source_sha256 '8e7c1e2950b5b04c5944a981cb31fffbf9d2ddda939d536838ebc854481afd5b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libedit'
  depends_on 'readline'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-static',
      '--enable-shared',
      '--enable-editline',
      '--enable-readline',
      '--enable-fts5',
      '--enable-json1',
      '--enable-session',
      '--with-pic'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
