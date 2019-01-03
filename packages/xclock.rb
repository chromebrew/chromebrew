require 'package'

class Xclock < Package
  description 'The xclock package contains a simple clock application which is used in the default xinit configuration.'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xclock.1.html'
  version '1.0.7'
  source_url 'https://www.x.org/pub/individual/app/xclock-1.0.7.tar.bz2'
  source_sha256 '23ceeca94e3e20a6c26a703ac7f789066d4517f8d2cb717ae7cb28a617d97dd0'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xorg_lib'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
