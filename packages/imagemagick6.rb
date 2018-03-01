require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-34'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-34.tar.xz'
  source_sha256 'b37d8ea71a367f0d2267e8441b470cc6f2eaac0ce94837dcc87b011c55bf212c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'lcms'
  depends_on 'lzma'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'freetype'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'python27'
  depends_on 'zlibpkg'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--with-python',
           '--without-x'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
