require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.42'
  license 'GPL-3+ and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.42.tar.xz'
  source_sha256 'aba83a0cbaa6c56edc29ea22f2e8172950a53b96daa51592083d59222bdde02d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.42_armv7l/gegl-0.4.42-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.42_armv7l/gegl-0.4.42-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.42_x86_64/gegl-0.4.42-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b0aba71d5f37ffc560c39786b193d7a32f122d62fe612a88539d3ed6e13102ae',
     armv7l: 'b0aba71d5f37ffc560c39786b193d7a32f122d62fe612a88539d3ed6e13102ae',
     x86_64: '17e36b43e2d5217b7df42f83c013a91c32df492d5b719665e9aada083e9a9173'
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
  depends_on 'ilmbase' # R
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
  depends_on 'zlibpkg' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dlibjpeg=enabled \
      -Dlibpng=enabled \
    builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
