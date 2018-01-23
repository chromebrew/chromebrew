require 'package'

class Imagemagick6 < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '6.9.9-27'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-6.9.9-27.tar.xz'
  source_sha256 '27d0090b6a019eb038d254a9eb8d8939ac0d225b5dc651abc9212bb7c257e17c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/imagemagick6-6.9.9-27-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fd9316207ade7c8ef35bcc47475c16b7e4b348f7f811bb4cb7c8070c24cd2b2e',
     armv7l: 'fd9316207ade7c8ef35bcc47475c16b7e4b348f7f811bb4cb7c8070c24cd2b2e',
       i686: '0cf502b48da21570e9952a98fb9b52e6b761ddb1564c6dcde210984bf80250b0',
     x86_64: '9c23d6415bb4c7fe77a4fdf6ebf7a17437916e326e849af42afe07efad8a5979',
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
