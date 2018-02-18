require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.1'
  source_url 'https://ftpmirror.gnu.org/gdb/gdb-8.1.tar.xz'
  source_sha256 'af61a0263858e69c5dce51eab26662ff3d2ad9aa68da9583e8143b5426be4b34'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on "ncurses"
  depends_on "texinfo"

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
