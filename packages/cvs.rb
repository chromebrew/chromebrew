require 'package'

class Cvs < Package
  description "CVS is a version control system, an important component of Source Configuration Management (SCM). Using it, you can record the history of sources files, and documents. It fills a similar role to the free software RCS, PRCS, and Aegis packages."
  homepage "http://www.nongnu.org/cvs/"
  version "1.11.23"
  source_url "https://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.23/cvs-1.11.23.tar.bz2"
  source_sha256 "400f51b59d85116e79b844f2d5dbbad4759442a789b401a94aa5052c3d7a4aa9"
  
  depends_on 'gcc'
  
  def self.build
    system "sed 's/getline /get_line /' <lib/getline.c >lib/getline.c2" # A bug in cvs, read here: http://permalink.gmane.org/gmane.linux.lfs.devel/10198
    system "sed 's/getline /get_line /' <lib/getline.h >lib/getline.h2"
    system "mv lib/getline.h2 lib/getline.h"
    system "mv lib/getline.c2 lib/getline.c"
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
