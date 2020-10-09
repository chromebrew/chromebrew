require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.1.0'
  compatibility 'all'
  source_url 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.1.0.tar.gz'
  source_sha256 '98a052268cc4d5ece27f76572a7f50293f439c17a98e67c4ea0c7ed6f50ef043'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '68c849400666f459e7c8e521a2cd1bb0303acbfdb7ffec9e07c57b24b7262555',
     armv7l: '68c849400666f459e7c8e521a2cd1bb0303acbfdb7ffec9e07c57b24b7262555',
       i686: '95ded30a5a8f9a448a2d02f528a207a1ef70417b41f1d3087f3f9b9eac78574e',
     x86_64: '3fc837c1a69cc0970450b60644b2aa977cf061dd4379a4250509e08aa4ba0c71',
  })

  depends_on 'libpng'
  depends_on 'libsdl'
  depends_on 'libtiff'
  depends_on 'mesa'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-libwebpmux',
           '--enable-libwebpdemux',
           '--enable-libwebpdecoder',
           '--enable-libwebpextras'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
