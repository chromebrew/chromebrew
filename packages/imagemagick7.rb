require 'package'

class Imagemagick7 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.8-14'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.8-14.tar.xz'
  source_sha256 '70c3d8c800cfd0282c0e0d9930b83f472f9593a882adc77532aa82c0d7ca0bb1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick7-7.0.8-14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '17f6dea62e438159afb39eb5f02c94669bc79034efad2e7c71c384fc20b768db',
     armv7l: '17f6dea62e438159afb39eb5f02c94669bc79034efad2e7c71c384fc20b768db',
       i686: '2b36de4345ad051651732c77b65ee9d8719e9c686e2616a0aa05f74d7f976a7e',
     x86_64: 'db12c715992606dce557b5e3b81d82384e9751d9c59f3cffc9115727688cc304',
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
