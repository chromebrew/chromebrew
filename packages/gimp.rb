require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.99.14'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/gimp/v2.99/gimp-2.99.14.tar.xz'
  source_sha256 '313a205475d1ff03c5c4d9602f09f5c975ba6c1c79d8843e2396f9fe2abdf7a8'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.99.14_armv7l/gimp-2.99.14-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.99.14_armv7l/gimp-2.99.14-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.99.14_i686/gimp-2.99.14-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.99.14_x86_64/gimp-2.99.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a1e0ae2ca1ed77cb11d746745fa4103231c7fd61959d745f2c803dcc5de29e8d',
     armv7l: 'a1e0ae2ca1ed77cb11d746745fa4103231c7fd61959d745f2c803dcc5de29e8d',
       i686: '0508068761b35033e80f25866f54d835a63f967da7eec4547b32f0f213d272d0',
     x86_64: '40972b5410efa1d614286ea762d2dfcf969e346f893b172000d4e06784dbca22'
  })

  depends_on 'aalib' # R
  depends_on 'alsa_lib' # R
  depends_on 'appstream_glib' # R
  depends_on 'at_spi2_core' => :build
  depends_on 'babl' # R
  depends_on 'bz2' # R
  depends_on 'cairo' # R
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gegl' # R
  depends_on 'gexiv2' # R
  depends_on 'ghostscript' # R
  depends_on 'gjs' # L
  depends_on 'glibc' # R
  depends_on 'glib_networking'
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'ilmbase' # R
  depends_on 'jsonc' => :build
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libavif' => :build
  depends_on 'libexif' => :build
  depends_on 'libgudev' # R
  depends_on 'libheif' => :build
  depends_on 'libice' => :build
  depends_on 'libjpeg' # R
  depends_on 'libjxl' # R
  depends_on 'libmng' # R
  depends_on 'libmypaint' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsm' => :build
  depends_on 'libtiff' # R
  depends_on 'libunwind' # R
  depends_on 'libwebp' # R
  depends_on 'libwmf' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxmu' # R
  depends_on 'libxpm' # R
  depends_on 'libxt' => :build
  depends_on 'luajit' # L
  depends_on 'luajit_lgi' # L
  depends_on 'mypaint_brushes_1' => :build
  depends_on 'openexr' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'poppler_data'
  depends_on 'poppler' # R
  depends_on 'pygobject' # L
  depends_on 'py3_pycairo' # L
  depends_on 'pygtk' => :build
  depends_on 'shared_mime_info' => :build
  depends_on 'xdg_base' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  gnome

  def self.build
    system "meson \
      #{CREW_MESON_OPTIONS} \
      -Dbug-report-url=https://github.com/chromebrew/chromebrew/issues \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
