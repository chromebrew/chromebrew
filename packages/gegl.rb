require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.38'
  license 'GPL-3+ and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.38.tar.xz'
  source_sha256 'e4a33c8430a5042fba8439b595348e71870f0d95fbf885ff553f9020c1bed750'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.38_armv7l/gegl-0.4.38-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.38_armv7l/gegl-0.4.38-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.38_i686/gegl-0.4.38-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.38_x86_64/gegl-0.4.38-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4c713267c64d796698b417600a04c395e7911a9ba3d1592280f04726d6489df7',
     armv7l: '4c713267c64d796698b417600a04c395e7911a9ba3d1592280f04726d6489df7',
       i686: '7f863bf987558c6377ff2b3468abadeb01406d2a3ca9f656143224fa6debf210',
     x86_64: 'df2e20437c9a9983ec80742191a343c5e096ff07fc3e73c3bfafbc123c43c8c6'
  })

  depends_on 'asciidoc'
  depends_on 'babl'
  depends_on 'cairo'
  depends_on 'enscript'
  depends_on 'ffmpeg'
  depends_on 'gdk_pixbuf'
  depends_on 'gexiv2'
  depends_on 'glib'
  depends_on 'graphviz'
  depends_on 'jasper'
  depends_on 'json_glib'
  depends_on 'lcms'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'librsvg'
  depends_on 'libsdl2'
  depends_on 'libtiff'
  depends_on 'libwebp'
  depends_on 'luajit'
  depends_on 'openexr'
  depends_on 'pango'
  depends_on 'poppler'
  depends_on 'vala'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dlibjpeg=enabled \
      -Dlibpng=enabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
