require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.40'
  license 'GPL-3+ and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.40.tar.xz'
  source_sha256 'cdde80d15a49dab9a614ef98f804c8ce6e4cfe1339a3c240c34f3fb45436b85d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.40_armv7l/gegl-0.4.40-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.40_armv7l/gegl-0.4.40-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.40_i686/gegl-0.4.40-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.40_x86_64/gegl-0.4.40-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '44e1852b0f8a9534bca83213b19caa7d8c21dd0e2cb6d70f543db283c501a1f7',
     armv7l: '44e1852b0f8a9534bca83213b19caa7d8c21dd0e2cb6d70f543db283c501a1f7',
       i686: '58ee62cb95cc60a75ecf91afe463b5896049f0206f112ec82e9abf5e24c4621f',
     x86_64: 'c874a01a85b80451716fdd6898ab3e1e2e2df6ef6296217aea1d444e58196b69'
  })

  depends_on 'asciidoc' => :build
  depends_on 'babl' # R
  depends_on 'cairo' # R
  depends_on 'enscript' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gexiv2' => :build
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' => :build # for dot
  depends_on 'harfbuzz' # R
  depends_on 'jasper' # R
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsdl2' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'luajit' => :build
  depends_on 'openexr' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'vala' => :build

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
