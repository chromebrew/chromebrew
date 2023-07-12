require 'package'

class Gegl < Package
  description 'GEGL (Generic Graphics Library) is a data flow based image processing framework, providing floating point processing and non-destructive image processing capabilities to GNU Image Manipulation Program and other projects.'
  homepage 'http://gegl.org/'
  version '0.4.46'
  license 'GPL-3+ and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gimp.org/pub/gegl/0.4/gegl-0.4.46.tar.xz'
  source_sha256 'd0b3b2481bc8774c5f3d0a487611910166d18eef823a859fb91e781ab7b1e892'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.46_armv7l/gegl-0.4.46-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.46_armv7l/gegl-0.4.46-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gegl/0.4.46_x86_64/gegl-0.4.46-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3d2ce127242c21dc77c195f46a424dc02fcd3e658f82ac921ec80ade05f45531',
     armv7l: '3d2ce127242c21dc77c195f46a424dc02fcd3e658f82ac921ec80ade05f45531',
     x86_64: 'b6a65235e852af43e7b917588abe96a804dc2095e652986997ab3a50f8bc3641'
  })

  depends_on 'asciidoc' => :build
  depends_on 'babl' # R
  depends_on 'cairo' # R
  depends_on 'enscript' => :build
  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
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
  depends_on 'source_highlight' => :build
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
      -Dlibjpeg=enabled \
      -Dlibpng=enabled \
      builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
