require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.2.1'
  source_url 'https://ftpmirror.gnu.org/gdb/gdb-8.2.1.tar.xz'
  source_sha256 '0a6a432907a03c5c8eaad3c3cffd50c00a40c3a5e3c4039440624bae703f2202'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'texinfo'
  depends_on 'libx11'
  depends_on 'expat'
  depends_on 'python3'
  depends_on 'python27'
  depends_on 'ncurses'
  depends_on 'readline7'

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
