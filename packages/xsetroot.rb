require 'package'

class Xsetroot < Package
  description 'Root window parameter setting utility for X'
  homepage 'https://www.x.org/archive/X11R7.5/doc/man/man1/xsetroot.1.html'
  version '1.1.2'
  source_url 'https://www.x.org/releases/individual/app/xsetroot-1.1.2.tar.bz2'
  source_sha256 '10c442ba23591fb5470cea477a0aa5f679371f4f879c8387a1d9d05637ae417c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xbitmaps'
  depends_on 'libxcursor'
  depends_on 'libxmu'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
