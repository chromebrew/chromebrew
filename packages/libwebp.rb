require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '0.6.1'
  source_url 'https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.1.tar.gz'
  source_sha256 '06503c782d9f151baa325591c3579c68ed700ffc62d4f5a32feead0ff017d8ab'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-0.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31c50e823a1a4c3738fc7b205a763653d03f6c567c23c624252d40f6b01fa25a',
     armv7l: '31c50e823a1a4c3738fc7b205a763653d03f6c567c23c624252d40f6b01fa25a',
       i686: '7ceece5c2f15e3d55bdc93426c048fa4fe2b9c425217f0cf03ded2380f0b8a1a',
     x86_64: '749abdd3f587597de4aa19a0ebfc3a014d48c08e2304249e8b1533eee6e6fb67',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
