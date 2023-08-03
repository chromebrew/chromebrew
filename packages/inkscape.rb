require 'buildsystems/cmake'

class Inkscape < CMake
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '1.3'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://inkscape.org/gallery/item/42328/inkscape-1.3.tar.xz'
  source_sha256 'bf4f286b025e0169b8948cc14d5199a9b4c204d761c894c4b48496571ec76307'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.3_armv7l/inkscape-1.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.3_armv7l/inkscape-1.3-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.3_x86_64/inkscape-1.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e155f44dcc4ef18ca31f5d440c0adb5dfaa9c35740b1298b9aee93a8062a50dd',
     armv7l: 'e155f44dcc4ef18ca31f5d440c0adb5dfaa9c35740b1298b9aee93a8062a50dd',
     x86_64: 'bc033557c8db10dd43f84151ddb1a35c541bad6fbdc6fee3af8f2c320fa51bae'
  })

  depends_on 'atkmm16' # R
  depends_on 'at_spi2_core' # R
  depends_on 'bdwgc' # R
  depends_on 'boost' # R
  depends_on 'cairomm_1_0' # R
  depends_on 'cairo' # R
  depends_on 'double_conversion' # R
  depends_on 'enchant' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'graphicsmagick' # R
  depends_on 'gsl' # R
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'gtkmm3' # R
  depends_on 'gtksourceview_4' # R
  depends_on 'gtksourceview' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'jemalloc' => :build
  depends_on 'lcms' # R
  depends_on 'libcdr' # R
  depends_on 'libepoxy' # R
  depends_on 'libice' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'librevenge' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'libsm' # R
  depends_on 'libsoup2' # R
  depends_on 'libvisio' # R
  depends_on 'libwpg' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'llvm16_lib' => :build
  depends_on 'pangomm_1_4' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'popt' => :build
  depends_on 'potrace' # R
  depends_on 'py3_cython' => :build
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R

  cmake_options '-DWITH_IMAGE_MAGICK=OFF \
            -DWITH_INTERNAL_2GEOM=ON \
            -DWITH_MANPAGE_COMPRESSION=OFF \
            -DWITH_X11=ON'
end
