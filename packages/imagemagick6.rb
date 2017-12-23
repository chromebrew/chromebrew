require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-27'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-27.tar.xz'
  source_sha256 '27d0090b6a019eb038d254a9eb8d8939ac0d225b5dc651abc9212bb7c257e17c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pkgconfig' => :build
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "freetype"
  depends_on "zlibpkg"

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--without-python'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
