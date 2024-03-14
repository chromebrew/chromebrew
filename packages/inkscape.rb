require 'buildsystems/cmake'

class Inkscape < CMake
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '1.3.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://media.inkscape.org/dl/resources/file/inkscape-1.3.2.tar.xz'
  source_sha256 'dbd1844dc443fe5e10d3e9a887144e5fb7223852fff191cfb5ef7adeab0e086b'
  binary_compression 'tar.zst'


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

  def self.patch
    downloader 'https://gitlab.archlinux.org/archlinux/packaging/packages/inkscape/-/raw/main/inkscape-1.3.2-poppler-24.03.patch?ref_type=heads&inline=false', '499bc0bd0d8600b597220f463034d5e132e69c7833108d6b766445e70e9c82ed', 'poppler.patch'
    system 'patch -p1 -i poppler.patch'
    # libxml compatibility patch
    downloader 'https://gitlab.com/inkscape/inkscape/-/merge_requests/6089.patch', 'edc55ad0771b604c63737524fc5928a35334db04d6479e395801635d5f6dfc1f'
    system 'patch -p1 -i 6089.patch'
  end

end
