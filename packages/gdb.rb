require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.0'
  source_url 'http://ftp.gnu.org/gnu/gdb/gdb-8.0.tar.xz'
  source_sha256 'f6a24ffe4917e67014ef9273eb8b547cb96a13e5ca74895b06d683b391f3f4ee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gdb-8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8612b39c8041b7ca574f0689f74a733c0ed168227495bcbc7ef2588dde5e314b',
     armv7l: '8612b39c8041b7ca574f0689f74a733c0ed168227495bcbc7ef2588dde5e314b',
       i686: 'fcaac403d13015720d0ef469545041a2bcff0b4d0f3bdba48380acfd8ac17385',
     x86_64: 'f58b46880dd963748d604bca3cb9db9e108c64142e45d7df42b389acc0a085f2',
  })

  depends_on "buildessential"
  depends_on "ncurses"
  depends_on "texinfo"

  def self.build
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
