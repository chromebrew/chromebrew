require 'package'

class Ncdc < Package
  description 'Ncdc is a modern and lightweight direct connect client with a friendly ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdc'
  version '1.20'
  compatibility 'all'
  source_url 'https://dev.yorhel.nl/download/ncdc-1.20.tar.gz'
  source_sha256 '8a998857df6289b6bd44287fc06f705b662098189f2a8fe95b1a5fbc703b9631'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ncdc-1.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ncdc-1.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ncdc-1.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ncdc-1.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '29c39214a120bd002a78b118a53daa085530e837a6b67f1cf10bbaa7d1991524',
     armv7l: '29c39214a120bd002a78b118a53daa085530e837a6b67f1cf10bbaa7d1991524',
       i686: 'f28d8e26a29f6c2d555f591e5b3552aa1231fc843f52b827950ab67293443f2f',
     x86_64: '7d72e59960fa27fef99a6f45c0fc9fc86b62931851c811d192e60d1376829452',
  })

  depends_on 'ncurses'
  depends_on 'zlibpkg'
  depends_on 'bz2'
  depends_on 'sqlite'
  depends_on 'glib'
  depends_on 'gnutls'
  depends_on 'geoip'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw",
           '--with-geoip'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
