require 'package'

class Sqlite < Package
  description 'SQLite is a self-contained, high-reliability, embedded, full-featured, public-domain, SQL database engine.'
  homepage 'http://www.sqlite.org/'
  version '3.24.0'
  source_url 'https://www.sqlite.org/2018/sqlite-autoconf-3240000.tar.gz'
  source_sha256 'd9d14e88c6fb6d68de9ca0d1f9797477d82fc3aed613558f87ffbdbbc5ceb74a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.24.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.24.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.24.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sqlite-3.24.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b4246d7a44b323908c8bbb00328597caa385c430adb72a350ac7dcc28667edd2',
     armv7l: 'b4246d7a44b323908c8bbb00328597caa385c430adb72a350ac7dcc28667edd2',
       i686: '27ef7d2aeaebef32a59aeaa81a254e63d2bb81715b26f86ff1abc658aa4aed13',
     x86_64: 'ce04fb085392fda58be8416bd4b826b89c7302b68a491394009cdecf474ad801',
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
