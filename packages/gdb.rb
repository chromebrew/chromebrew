require 'package'

class Gdb < Package
  description 'GDB, the GNU Project debugger, allows you to see what is going on 'inside' another program while it executes -- or what another program was doing at the moment it crashed.'
  homepage 'https://www.gnu.org/software/gdb/'
  version '7.12.1.' 
  source_url 'https://ftp.gnu.org/gnu/gdb/gdb-7.12.1.tar.xz'
  source_sha1 'ef77c5345d6f9fdcdf7a5d8503301242b701936e'

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
