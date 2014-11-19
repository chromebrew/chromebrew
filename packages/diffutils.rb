require 'package'

class Diffutils < Package
  version '3.3'
  source_url 'ftp://ftp.gnu.org/gnu/diffutils/diffutils-3.3.tar.xz'
  source_sha1 '6463cce7d3eb73489996baefd0e4425928ecd61e'

  depends_on "libsigsegv"

  def self.build
    system "sed -i -e '/gets is a/d' lib/stdio.in.h"  # fixes an error, credit to http://www.linuxfromscratch.org/lfs/view/7.3/chapter05/diffutils.html
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
