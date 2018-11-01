require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.10-14'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.10-14.tar.xz'
  source_sha256 'd123d4ad4e5bf72c51a6f528a2dbbbd4bf4249f25b36045017c9c634db968e6d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.10-14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '35aa98c93aedcf992741a8fc5043608618c3960ff4a7163e05dab46301cf0695',
     armv7l: '35aa98c93aedcf992741a8fc5043608618c3960ff4a7163e05dab46301cf0695',
       i686: '2d517abdea774d9a2425b8b13e5fc2c94a8596e2fa058ed8871aa6295d5edd40',
     x86_64: '5a8b8ff05c66cf29715166b18c4100481577e2501332741f78eda177d19240d4',
  })

  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'lzma'
  depends_on 'libwebp'
  depends_on 'msttcorefonts'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'python27'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
