require 'buildsystems/cmake'

class Inkscape < CMake
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '1.3.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://inkscape.org/gallery/item/44467/inkscape-1.3.1.tar.xz'
  source_sha256 '421e0035fe5b3b054a0865dc8235be3f9e6e2dea54190d926b880a4ce05b00d8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2fa1d4d51162d63e63059e85dc769ad4e561170cc683d61de39903504e8e0ce7',
     armv7l: '2fa1d4d51162d63e63059e85dc769ad4e561170cc683d61de39903504e8e0ce7',
     x86_64: 'c2bcaa2c535c20efacfa5974808012696f15d90a74298e82936a0e5b5e8994ef'
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
  depends_on 'xdg_base' # R
  depends_on 'zlibpkg' # R

  cmake_options '-DWITH_IMAGE_MAGICK=OFF \
            -DWITH_INTERNAL_2GEOM=ON \
            -DWITH_MANPAGE_COMPRESSION=OFF \
            -DWITH_X11=ON'
end
