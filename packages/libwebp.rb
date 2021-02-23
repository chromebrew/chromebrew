require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.2.0-1'
  compatibility 'all'
  source_url 'http://downloads.webmproject.org/releases/webp/libwebp-1.2.0.tar.gz'
  source_sha256 '2fc8bbde9f97f2ab403c0224fb9ca62b2e6852cbc519e91ceaa7c153ffd88a0c'

  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libjpeg'
  depends_on 'libsdl'
  depends_on 'giflib'
  depends_on 'mesa'

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
    system  "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --enable-libwebpmux \
      --enable-libwebpdemux \
      --enable-libwebpdecoder \
      --enable-libwebpextras \
      --enable-sdl \
      --enable-tiff \
      --enable-jpeg \
      --enable-png \
      --enable-gif"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
