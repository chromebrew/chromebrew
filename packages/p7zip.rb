require 'package'

class P7zip < Package
  description 'p7zip is a port of 7za.exe for POSIX systems like Unix (Linux, Solaris, OpenBSD, FreeBSD, Cygwin, AIX, ...), MacOS X and also for BeOS and Amiga.'
  homepage 'http://p7zip.sourceforge.net/'
  version '16.02'
  source_url 'http://downloads.sourceforge.net/p7zip/p7zip_16.02_src_all.tar.bz2'
  source_sha1 'e8819907132811aa1afe5ef296181d3a15cc8f22'

  def self.build
    system "cp", "makefile.linux_any_cpu", "makefile.machine"
    system "make", "all3"
  end

  def self.install
    system "make", "DEST_DIR=#{CREW_DEST_DIR}", "install" 
  end
end
