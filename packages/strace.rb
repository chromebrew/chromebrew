require 'package'

class Strace < Package
  description 'strace is a diagnostic, debugging and instructional userspace utility for Linux.'
  homepage 'https://strace.io/'
  version '4.20'
  source_url 'https://downloads.sourceforge.net/project/strace/strace/4.20/strace-4.20.tar.xz'
  source_sha256 '5bf3148dd17306a42566f7da17368fdd781afa147db05ea63a4ca2b50f58c523'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential'

  def self.build
    system "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
