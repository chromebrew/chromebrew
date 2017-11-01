require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-9'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-9.tar.xz'
  source_sha256 '59eed394d295d651e49ec0f3cfe3f0bb7aeccc28bd7a32360db9f8fc4bf9f25c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '47f4ff5ff0947d57e51e562c4a08b4d4cd0f27869a98c22fe9db5b7db602b50d',
     armv7l: '47f4ff5ff0947d57e51e562c4a08b4d4cd0f27869a98c22fe9db5b7db602b50d',
       i686: '542104fc736d4bb18fd5dd9014821c3577e46f31f791cd52f2cf2b35e45d405b',
     x86_64: '4cdd257d81e69fad866ce8aa7dbc2ad5a413220a2c97c4e90358d60e30bab8b8',
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
