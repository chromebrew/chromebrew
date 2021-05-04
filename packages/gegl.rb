require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.30'
  license 'GPL-3+ and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.30.tar.xz'
  source_sha256 'c112782cf4096969e23217ccdfabe42284e35d5435ff0c43d40e4c70faeca8dd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.30_armv7l/gegl-0.4.30-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.30_armv7l/gegl-0.4.30-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.30_i686/gegl-0.4.30-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.30_x86_64/gegl-0.4.30-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '25258b3592ddf748f011e3fc0a44ccb3ce0ba24ae33d030df592f34210eef04b',
     armv7l: '25258b3592ddf748f011e3fc0a44ccb3ce0ba24ae33d030df592f34210eef04b',
       i686: 'a941d0bf5b9bfcd10affa27e9fa16f1d359ded89ee5c3c20d8bc8f5b8afb90aa',
     x86_64: '1a3f632903fc5586708ea179d3f55d7255ccb716025187aa1740289e513c4ea1'
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
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
