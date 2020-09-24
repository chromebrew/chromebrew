require 'package'

class Libtiff < Package
  description 'LibTIFF provides support for the Tag Image File Format (TIFF), a widely used format for storing image data.'
  homepage 'http://www.libtiff.org/'
  version '4.1.0'
  compatibility 'all'
  source_url 'https://download.osgeo.org/libtiff/tiff-4.1.0.tar.gz'
  source_sha256 '5d29f32517dadb6dbcd1255ea5bbc93a2b54b94fbf83653b4d65c7d6775b8634'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtiff-4.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '130c8ef969b06b24f0fd67b4b28b8932a7c96f5326e502d760efaaf4bf7bc850',
     armv7l: '130c8ef969b06b24f0fd67b4b28b8932a7c96f5326e502d760efaaf4bf7bc850',
       i686: '596e5034c8bd7cbecd28d6aa00aa0919b97a1cdc27325b4260015047d761a5cf',
     x86_64: 'c25ec510ec23d166ab0edfa20984b1df4325b82d7e72405d483d173480586910',
  })

  def self.build
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS}"
    system 'make'
  end

  depends_on 'libjpeg'

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
