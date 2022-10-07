require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.99.12'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/gimp/v2.99/gimp-2.99.12.tar.xz'
  source_sha256 '7ba1b032ea520d540e4acad3da16d8637fe693743fdb36e0121775eea569f6a3'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.99.12_x86_64/gimp-2.99.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'ec0ae1894433edb9184989aaccee21474e1cf6bde43eb1d5fbe24f077682881f'
  })

  depends_on 'aalib'
  depends_on 'alsa_lib'
  depends_on 'atk'
  depends_on 'babl'
  depends_on 'cairo'
  depends_on 'ffmpeg'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'gegl'
  depends_on 'gexiv2'
  depends_on 'ghostscript'
  depends_on 'gjs'
  depends_on 'glib'
  depends_on 'glib_networking'
  depends_on 'gtk2'
  depends_on 'harfbuzz'
  depends_on 'ilmbase'
  depends_on 'jsonc'
  depends_on 'json_glib'
  depends_on 'lcms'
  depends_on 'libavif'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libheif'
  depends_on 'libice'
  depends_on 'libjpeg'
  depends_on 'libmng'
  depends_on 'libmypaint'
  depends_on 'libpng'
  depends_on 'librsvg'
  depends_on 'libsm'
  depends_on 'libtiff'
  depends_on 'libunwind'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'libx11'
  depends_on 'libxcursor'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxmu'
  depends_on 'libxpm'
  depends_on 'libxt'
  depends_on 'mypaint_brushes_1'
  depends_on 'openexr'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'poppler'
  depends_on 'poppler_data'
  depends_on 'py3_pycairo'
  depends_on 'pygtk'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'sommelier'

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
