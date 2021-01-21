require 'package'

class Cvs < Package
  description "CVS is a version control system, an important component of Source Configuration Management (SCM). Using it, you can record the history of sources files, and documents. It fills a similar role to the free software RCS, PRCS, and Aegis packages."
  homepage "http://www.nongnu.org/cvs/"
  version "1.11.23-1"
  compatibility 'all'
  source_url "https://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.23/cvs-1.11.23.tar.bz2"
  source_sha256 "400f51b59d85116e79b844f2d5dbbad4759442a789b401a94aa5052c3d7a4aa9"

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '89026095bdd1ce7a832e717d04dbf82dd4edeee4234d66da5a42b7c540fbda20',
     armv7l: '89026095bdd1ce7a832e717d04dbf82dd4edeee4234d66da5a42b7c540fbda20',
       i686: '34354bff1e1f899793c430458e5aa4ac9d0268af14bace13d1ba1371677f7080',
     x86_64: '15b3d7119405f6703d20f8b566ae4c4f3ff72bd6d5223bb3aa919250f0456349',
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
