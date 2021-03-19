require 'package'

class Moreutils < Package
  description 'moreutils is a growing collection of the unix tools that nobody thought to write long ago when unix was young.'
  homepage 'https://joeyh.name/code/moreutils/'
  @_ver = '0.65'
  version @_ver
  compatibility 'all'
  source_url "http://http.debian.net/debian/pool/main/m/moreutils/moreutils_#{@_ver}.orig.tar.xz"
  source_sha256 'ba0cfaa1ff6ead2b15c62a67292de66a366f9b815a09697b54677f7e15f5a2b2'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.65-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.65-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.65-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/moreutils-0.65-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'af2d40444fb74ae8e2151b76d61417ddee993b69b8e6b6b30a65218612a8f523',
      armv7l: 'af2d40444fb74ae8e2151b76d61417ddee993b69b8e6b6b30a65218612a8f523',
        i686: '5bb54745aa76aa985f0cc0a6dd2a7c6efdcd314774df9d535183b657247c9540',
      x86_64: '55222b8e4293e548f812542fa7447e5420c1b7098c0ae481e1f0a0357dd84ed9',
  })

  depends_on 'docbook_xml' => :build
  depends_on 'libxslt' => :build

  def self.build
    system "sed -i 's,PREFIX?=/usr,PREFIX?=#{CREW_PREFIX},' Makefile"
    system "sed -i 's,DOCBOOKXSL?=/usr/share/xml/docbook/stylesheet/docbook-xsl,DOCBOOKXSL?=#{CREW_PREFIX}/share/xml/docbook/stylesheet/docbook-xsl,' Makefile"
    system "sed -i 's,share/man,man,g' Makefile"
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
