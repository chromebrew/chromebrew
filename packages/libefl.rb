# This package should definitely be split into its constituent parts sometime.

require 'package'

class Libefl < Package
  description 'Enlightenment Foundation Libraries'
  homepage 'https://enlightenment.org'
  version '1.26.3'
  license 'BSD, BSD-2, BSD-3, LGPL-2.1, GPL-2, freetype, MIT, Apache-2.0' # Needs verifiying
  compatibility 'all'
  source_url 'https://download.enlightenment.org/rel/libs/efl/efl-1.26.3.tar.xz'
  source_sha256 'd9f83aa0fd9334f44deeb4e4952dc0e5144683afac786feebce6030951617d15'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libefl/1.26.3_armv7l/libefl-1.26.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libefl/1.26.3_armv7l/libefl-1.26.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libefl/1.26.3_i686/libefl-1.26.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libefl/1.26.3_x86_64/libefl-1.26.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f1bf40ac1f75c23e2eccc2b1aae3e8df459ed3a7155fffae17a89bd6f082d277',
     armv7l: 'f1bf40ac1f75c23e2eccc2b1aae3e8df459ed3a7155fffae17a89bd6f082d277',
       i686: 'e0f1ddc89d693ecbb627f957c56e5764eaf471acd8ab17f51d001112e5db79e1',
     x86_64: 'c1761b15c8a7910deff5fd58282197b91609db928b4ed880a210827c46fba301'
  })

  depends_on 'lz4'
  depends_on 'libusb'
  depends_on 'fontconfig'
  depends_on 'fribidi'
  depends_on 'libjpeg'
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
  depends_on 'libxss'
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
  depends_on 'dbus' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'lcms' # R
  depends_on 'libgcrypt' # R
  depends_on 'libglvnd' # R
  depends_on 'libinput' # R
  depends_on 'libunwind' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxtst' # R
  depends_on 'util_linux' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
       -Dcrypto=gnutls \
       -Dsystemd=false \
       -Dglib=false \
       -Dgstreamer=false \
       -Decore-imf-loaders-disabler=ibus,scim \
       builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
