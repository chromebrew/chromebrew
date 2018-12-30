require 'package'

class Cvs < Package
  description "CVS is a version control system, an important component of Source Configuration Management (SCM). Using it, you can record the history of sources files, and documents. It fills a similar role to the free software RCS, PRCS, and Aegis packages."
  homepage "http://www.nongnu.org/cvs/"
  version "1.11.23-1"
  source_url "https://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.23/cvs-1.11.23.tar.bz2"
  source_sha256 "400f51b59d85116e79b844f2d5dbbad4759442a789b401a94aa5052c3d7a4aa9"

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'krb5' # Works in krb4 compatibility mode.

  def self.patch
    system "sed -i 's,getline,cvs_getline,g' \
            lib/getline.h src/root.c src/subr.c src/cvsrc.c src/server.c src/ignore.c \
            src/logmsg.c src/update.c src/release.c src/repos.c src/client.c src/patch.c \
            src/login.c src/fileattr.c src/mkmodules.c src/myndbm.c src/wrapper.c src/parseinfo.c \
            src/edit.c src/commit.c src/entries.c lib/getline.c lib/getpass.c"
    system 'ln -s getline.h lib/cvs_getline.h'
  end

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--with-krb4=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
