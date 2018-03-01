require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.22.0'
  source_url 'https://www.sqlite.org/2018/sqlite-autoconf-3220000.tar.gz'
  source_sha256 '2824ab1238b706bc66127320afbdffb096361130e23291f26928a027b885c612'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.22.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.22.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.22.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.22.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b7f9778a780ab585a278f2c5683fe0db797862bb38d1d5800dfbacfa1b013f6',
     armv7l: '5b7f9778a780ab585a278f2c5683fe0db797862bb38d1d5800dfbacfa1b013f6',
       i686: 'aa56673a95856c12a8062493e47648f69cb6e94461dd75ef26477535f39647ba',
     x86_64: '94d9f6a054d92a09c04324c0a95d6af4d2cc155dfac2a72879479d7a5d6129b8',
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
