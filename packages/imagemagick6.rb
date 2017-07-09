require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-5'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-5.tar.xz'
  source_sha256 'aa6444ece8d29b87fb4f25e997cd0b4fb48774206cea9490c6028babdee7d056'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/imagemagick6-6.9.9-4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/imagemagick6-6.9.9-4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/imagemagick6-6.9.9-4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/imagemagick6-6.9.9-4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1be330d6dead68de12dc60877f5251966f7844035ef292cf68e239ee779691c5',
     armv7l: '1be330d6dead68de12dc60877f5251966f7844035ef292cf68e239ee779691c5',
       i686: '8f37a7b8f1c537d51c4e84c6cf35798889c0dc217c7a184b1f69f9d7d5a2355a',
     x86_64: 'b5a07cf34ab6ed131295def83cc8f39cd80ae0c4a139cdda2f4a33de10b586ea',
  })

  depends_on 'pkgconfig'
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "freetype"
  depends_on "zlibpkg"

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
