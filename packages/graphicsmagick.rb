require 'package'

class Graphicsmagick < Package
  description 'GraphicsMagick is the swiss army knife of image processing.'
  homepage 'http://www.graphicsmagick.org/'
  version '1.3.30'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/graphicsmagick/graphicsmagick/1.3.30/GraphicsMagick-1.3.30.tar.xz'
  source_sha256 'd965e5c6559f55eec76c20231c095d4ae682ea0cbdd8453249ae8771405659f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.30-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.30-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphicsmagick-1.3.30-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c2a653efa6a3ee47ef4cf50fc10965dd16e3acdee0baa3668ef2899d147cf6e4',
     armv7l: 'c2a653efa6a3ee47ef4cf50fc10965dd16e3acdee0baa3668ef2899d147cf6e4',
       i686: '5b44100564bf0e4910c9559cc4eca9a5ed3dea91ce3f47dfceb2bf885aa2d6c2',
     x86_64: '8554b70d6ba8428089a26b61d1534874691d55fda6fedc6d69e79af53c3c7526',
  })

  depends_on 'docutils'
  depends_on 'freetype'
  depends_on 'ghostscript'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'msttcorefonts'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-windows-font-dir=#{CREW_PREFIX}/share/fonts/truetype/msttcorefonts",
           "--with-perl=#{CREW_PREFIX}/bin/perl",
           '--disable-maintainer-mode',
           '--enable-magick-compat',
           '--enable-shared=yes',
           '--enable-static=no',
           '--with-modules',
           '--with-xml'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
