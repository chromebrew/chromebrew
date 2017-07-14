require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on \'inside\' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '8.0'
  source_url 'http://ftp.gnu.org/gnu/gdb/gdb-8.0.tar.xz'
  source_sha256 'f6a24ffe4917e67014ef9273eb8b547cb96a13e5ca74895b06d683b391f3f4ee'

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
