require 'package'

class Font_util < Package
  description 'Tools for truncating and subseting of ISO10646-1 BDF fonts'
  homepage 'https://xorg.freedesktop.org'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/font/font-util-1.3.2.tar.bz2'
  source_sha256 '3ad880444123ac06a7238546fa38a2a6ad7f7e0cc3614de7e103863616522282'

  depends_on 'util_macros'

  def self.build
      system "./configure #{CREW_OPTIONS} "
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
