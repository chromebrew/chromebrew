require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '0.6.0'
  source_url 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.0.tar.gz'
  source_sha256 'c928119229d4f8f35e20113ffb61f281eda267634a8dc2285af4b0ee27cf2b40'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libwebp-0.6.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libwebp-0.6.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libwebp-0.6.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libwebp-0.6.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f35c27b6360a7d7750e5f0ce841a0b3769bf3f0e65db84d82f2d3480fb99365c',
     armv7l: 'f35c27b6360a7d7750e5f0ce841a0b3769bf3f0e65db84d82f2d3480fb99365c',
       i686: 'f5aa924cd9837b5f0f408432b718638a65e6fef4d29b071c172636e9c29a5a27',
     x86_64: '6db6eaed9f0ce7761a41f40b42e6d5db9fdc4e60cd20e35a43decaee17f3cd06',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
