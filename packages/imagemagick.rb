require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.7-15'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.7-15.tar.xz'
  source_sha256 '9809be6bab0c5258721a5c5bbe8bccf61357b506024f8514d94e9efcd575a69d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.7-15-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.7-15-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.7-15-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick-7.0.7-15-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '702365fbf31a26bbd0e395ba1d3fae2cbb9112ae8e5a8fd114bcb00bc0c6b7b6',
     armv7l: '702365fbf31a26bbd0e395ba1d3fae2cbb9112ae8e5a8fd114bcb00bc0c6b7b6',
       i686: '386b84c9a0cc1b93171a89a086ef15b6f553c61d930da5087879b7c4d89b670d',
     x86_64: 'bd307f8ad7b79e89016679bf90da61159d25479ab5ce8bcbae0218f97387c0ed',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-python',
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
