require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.28.0'
  source_url 'https://sqlite.org/2019/sqlite-autoconf-3280000.tar.gz'
  source_sha256 'd61b5286f062adfce5125eaf544d495300656908e61fca143517afcc0a89b7c3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.28.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.28.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.28.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.28.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '81c476300ae1c045be072eb305163305faeb48c932d4c411d8f28373d1aad70a',
     armv7l: '81c476300ae1c045be072eb305163305faeb48c932d4c411d8f28373d1aad70a',
       i686: '41ff3ba7559641c2fbce5b387bc9ab85b5bb2095401813244c7bcaef0dc536be',
     x86_64: '13bc85cf0cfa0d52de43ff3381a14ffafe70e27447abbfe68a1324fcb0dc4611',
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
