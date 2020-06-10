require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.0.9'
  compatibility 'all'
  source_url 'ftp://download.osgeo.org/libtiff/tiff-4.0.9.tar.gz'
  source_sha256 '6e7bdeec2c310734e734d19aae3a71ebe37a4d842e0e23dbb1b8921c0026cfcd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '66ae653bdf59f79bfc0456f0f132ca052d9625fc796d65c4ff18f42c30f3884d',
     armv7l: '66ae653bdf59f79bfc0456f0f132ca052d9625fc796d65c4ff18f42c30f3884d',
       i686: '2eaa114ff1d6010921631b5b498f11e0d49fe1c11986c09a8826f832c7b321e0',
     x86_64: '256279df77d0772be848deb674f865b1c2359c018562ceb8bb6cbd06f8f28a2e',
  })

  def self.build
    system "./configure \
            CFLAGS=\" -fPIC\" \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  depends_on 'compressdoc' => :build
  depends_on 'libjpeg'
  depends_on 'zlibpkg'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man1"
    system "compressdoc --gzip -9 #{CREW_DEST_PREFIX}/share/man/man3"
  end
end
