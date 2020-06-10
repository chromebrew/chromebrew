require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.3'
  compatibility 'all'
  source_url 'http://ftpmirror.gnu.org/gdb/gdb-8.3.tar.xz'
  source_sha256 '802f7ee309dcc547d65a68d61ebd6526762d26c3051f52caebe2189ac1ffd72e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb31458449dbe3901b104a0e0629e9ef0cd219ea2783db736360d0176c321ca9',
     armv7l: 'cb31458449dbe3901b104a0e0629e9ef0cd219ea2783db736360d0176c321ca9',
       i686: '84bd95e06d5515647135ab5ce1f1c6a2956d5df8f324837dc26705fc28bcd07c',
     x86_64: 'afb397d5022e72ea19e7d87fff5167b798f5063f59b1174dd56337837fdc7dea',
  })

  depends_on 'libx11'
  depends_on 'six'

  def self.build
    system './configure',
           '--with-x',
           '--with-lzma',
           '--enable-sim',
           '--with-expat',
           '--enable-tui',
           '--with-python',
           '--with-curses',
           '--enable-shared',
           '--with-system-zlib',
           '--enable-64-bit-bfd',
           '--enable-host-shared',
           '--with-system-readline',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--with-pkgversion=Chromebrew'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
