require 'package'

class Ncdc < Package
  description 'Ncdc is a modern and lightweight direct connect client with a friendly ncurses interface.'
  homepage 'https://dev.yorhel.nl/ncdc'
  version '1.20'
  source_url 'https://dev.yorhel.nl/download/ncdc-1.20.tar.gz'
  source_sha256 '8a998857df6289b6bd44287fc06f705b662098189f2a8fe95b1a5fbc703b9631'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'ncursesw'
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
