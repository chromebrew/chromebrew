require 'package'

class Libwebp < Package
  description 'WebP is a modern image format that provides superior lossless and lossy compression for images on the web.'
  homepage 'https://developers.google.com/speed/webp/'
  version '1.2.0-1'
  compatibility 'all'
  source_url 'http://downloads.webmproject.org/releases/webp/libwebp-1.2.0.tar.gz'
  source_sha256 '2fc8bbde9f97f2ab403c0224fb9ca62b2e6852cbc519e91ceaa7c153ffd88a0c'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwebp-1.2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd1c5298b87e15ebcb33e7fb6a99ed6c4daf130b1efa2994abfe846c692bf34fc',
     armv7l: 'd1c5298b87e15ebcb33e7fb6a99ed6c4daf130b1efa2994abfe846c692bf34fc',
       i686: '45647f97cf2a589675a9326b542fdba4609c7fb9aa58f863322aa6937a9107a3',
     x86_64: '4c18160017de211353c5b82b603a2749ae421a05b15c39d285038f324f84c67b'
  })

  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libjpeg'
  depends_on 'libsdl'
  depends_on 'giflib'
  depends_on 'mesa'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
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
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
