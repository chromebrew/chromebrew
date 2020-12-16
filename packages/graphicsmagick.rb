require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.35'
  compatibility 'all'
  source_url 'http://ftp.icm.edu.pl/pub/unix/graphics/GraphicsMagick/1.3/GraphicsMagick-1.3.35.tar.gz'
  source_sha256 'd96d5ce2ef7e0e90166551e38742713728bfd33d6f18495a9ddda938700fc055'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.35-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.35-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.35-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.35-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd9ed09c58b7704161c7047edde788c7e505319531dc43e730523ce92396644f3',
     armv7l: 'd9ed09c58b7704161c7047edde788c7e505319531dc43e730523ce92396644f3',
       i686: 'c1b3247291a28df4aa768ac7226214c3d1e63700ad97103fe3c6a00c6d157dd3',
     x86_64: '0e5058139fd5c7a715fb8c182b82883fea66623c8029cf9d6bac9e3b51fd7a9e',
  })

  depends_on 'docutils'
  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'msttcorefonts'

  def self.build
    system "./configure #{CREW_OPTIONS} \
--with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts \
--with-perl=#{CREW_PREFIX}/bin/perl --disable-maintainer-mode \
--enable-magick-compat --enable-shared=yes --enable-static=no \
--with-modules --with-xml"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
