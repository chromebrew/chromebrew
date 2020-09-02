require 'package'

class Libefl < Package
  description 'Enlightenment Foundation Libraries'
  homepage 'https://enlightenment.org'
  version '1.24.3'
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/libs/efl/efl-1.24.3.tar.xz'
  source_sha256 'de95c6e673c170c1e21382918b122417c091c643e7dcaced89aa785529625c2a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libefl-1.24.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libefl-1.24.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libefl-1.24.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libefl-1.24.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a8711a86825b0186ce5749455cf1763c9a338a2dffdad78cdbf1eab185b6a879',
     armv7l: 'a8711a86825b0186ce5749455cf1763c9a338a2dffdad78cdbf1eab185b6a879',
       i686: 'e5f5bba5bdb07c1abaa60229fee05f97b6a617c60af647734a839340e38a8429',
     x86_64: 'be56db051dee123ac67bb9938acc09a930ba5a58e785b9a818d2ac74fbba97aa',
  })

  depends_on 'lz4'
  depends_on 'libusb'
  depends_on 'fontconfig'
  depends_on 'fribidi'
  depends_on 'libjpeg_turbo'
  depends_on 'libpng'
  depends_on 'giflib'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'avahi'
  depends_on 'eudev'
  depends_on 'bullet'
  depends_on 'libsndfile'
  depends_on 'luajit'
  depends_on 'poppler'
  depends_on 'librsvg'
  depends_on 'libspectre'
  depends_on 'libraw'
  depends_on 'openjpeg'
  depends_on 'gstreamer'
  depends_on 'mesa'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxp'
  depends_on 'libxrandr'
  depends_on 'libxscrnsaver'
  depends_on 'libxdamage'
  depends_on 'libxrender'
  depends_on 'libxi'
  depends_on 'libxinerama'
  depends_on 'libxpresent'
  depends_on 'xcb_util'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_image'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_wm'
  depends_on 'xorg_proto'
  depends_on 'gnutls'

  def self.build
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '-Dcrypto=gnutls',
           '-Dsystemd=false',
           '-Dglib=false',
           '-Dgstreamer=false',
           '-Decore-imf-loaders-disabler=ibus,scim',
           '-Demotion-loaders-disabler=gstreamer1,gstreamer,xine',
           '-Demotion-generic-loaders-disabler=vlc',
           '_build'
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
