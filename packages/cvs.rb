require 'package'

class Cvs < Package
  description "CVS is a version control system, an important component of Source Configuration Management (SCM). Using it, you can record the history of sources files, and documents. It fills a similar role to the free software RCS, PRCS, and Aegis packages."
  homepage "http://www.nongnu.org/cvs/"
  version "1.11.23"
  source_url "https://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.23/cvs-1.11.23.tar.bz2"
  source_sha256 "400f51b59d85116e79b844f2d5dbbad4759442a789b401a94aa5052c3d7a4aa9"

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cvs-1.11.23-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb71b4143236797fdf99f493e3ca5c8b2713d02a9deed0fbd4417d10b713c769',
     armv7l: 'bb71b4143236797fdf99f493e3ca5c8b2713d02a9deed0fbd4417d10b713c769',
       i686: '8f09aa1e4adea15bf50248a019bf7bc8a06eefd036d5d4941dd13df526b76656',
     x86_64: '77bb711a00b0f204092a7833e5f0a45b29d30e1440d0448769637708909fb655',
  })
  
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
