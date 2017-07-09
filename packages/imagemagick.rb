require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.6-7'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.6-7.tar.xz'
  source_sha256 '732332a76cb62f067d680a90d85dd05a2f2592e0017af83becb639d05681106d'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/imagemagick-7.0.6-7-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/imagemagick-7.0.6-7-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/imagemagick-7.0.6-7-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/imagemagick-7.0.6-7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c8aa6e01d8f29c77ed90ca6221ebbdff588653772b1561c408a3e6f73d5bd02e',
     armv7l: 'c8aa6e01d8f29c77ed90ca6221ebbdff588653772b1561c408a3e6f73d5bd02e',
       i686: '8ef193d2682140638ee4534da6fa7d249fed3f2dcdaa9aa3964d2b1f18932db9',
     x86_64: '315627005ae0e959a01c4f4ad221a62355a558522cb0b4e4b5d0f04ee7c76579',
  })

  depends_on 'buildessential' => :build

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
