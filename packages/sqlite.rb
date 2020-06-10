require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.29.0'
  compatibility 'all'
  source_url 'https://sqlite.org/2019/sqlite-autoconf-3290000.tar.gz'
  source_sha256 '8e7c1e2950b5b04c5944a981cb31fffbf9d2ddda939d536838ebc854481afd5b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.29.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.29.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.29.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.29.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9d9adb320dfdaaed8cf896f4338b0a78e75f0aa0d01d2c0480ff2c18dc4ed66f',
     armv7l: '9d9adb320dfdaaed8cf896f4338b0a78e75f0aa0d01d2c0480ff2c18dc4ed66f',
       i686: '18e1aaaa527230edc785c7637e8088fb8f10bf6aee8911ace8bd1d350e727ed7',
     x86_64: '71b432b2d4c2a030f2739754998ebeca05942625b93ef8ba96c4d00957feaf58',
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
