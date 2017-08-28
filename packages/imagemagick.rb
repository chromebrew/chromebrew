require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.6-10'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.6-10.tar.xz'
  source_sha256 '5a9889c87dc351cf4b57ca3ae418c9cdcefc77aaa9a3b16044ae8a4eecf3aeed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.6-10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.6-10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.6-10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.6-10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '037a93341e12a029a09dc9c4a0549b18cec7082da027fc5d218d9dcd9231e88e',
     armv7l: '037a93341e12a029a09dc9c4a0549b18cec7082da027fc5d218d9dcd9231e88e',
       i686: 'e5c8de20e68f5b608c7e0ae243096f01ce82fbe35c7a6464f4479eeb4254da43',
     x86_64: '1f409d7ce9007e3274685030b4f50743abb5ddb5fe7eab6c72e52960917bfa5f',
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
