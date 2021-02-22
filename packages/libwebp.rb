require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.2.0'
  compatibility 'all'
  source_url 'http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.0.tar.gz'
  source_sha256 '2fc8bbde9f97f2ab403c0224fb9ca62b2e6852cbc519e91ceaa7c153ffd88a0c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c156d14ddbfa22beeadedaa0d1a6ae949319ec605003866b39aea37070cf2313',
     armv7l: 'c156d14ddbfa22beeadedaa0d1a6ae949319ec605003866b39aea37070cf2313',
       i686: 'c195c44117804c73eada397285490d9f724c98bae35457fb687560442f27207e',
     x86_64: '248f9490dd57210c642929ab42879dd27a956cc6002164cc0276b600748d9866',
  })

  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libjpeg'
  depends_on 'libsdl'
  depends_on 'mesa'

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system "./configure #{CREW_OPTIONS} \
           --enable-libwebpmux \
           --enable-libwebpdemux \
           --enable-libwebpdecoder \
           --enable-libwebpextras \
           --enable-sdl \
           --enable-tiff \
           --enable-jpeg \
           --enable-png"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
