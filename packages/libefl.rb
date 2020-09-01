require 'package'

class Libefl < Package
  description 'Enlightenment Foundation Libraries'
  homepage 'https://enlightenment.org'
  version '1.24.3'
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/libs/efl/efl-1.24.3.tar.xz'
  source_sha256 'de95c6e673c170c1e21382918b122417c091c643e7dcaced89aa785529625c2a'

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
