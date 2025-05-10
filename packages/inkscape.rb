require 'buildsystems/cmake'

class Inkscape < CMake
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '1.4.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.37'
  source_url "https://media.inkscape.org/dl/resources/file/inkscape-#{version}.tar.xz"
  source_sha256 '74796a8af4e14a0d5d5c1cc58d3ec1ea6d488a04306dd6e8d32c11f0748d7232'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '475b434d8a0c408beb0dd6eae1cc56a2915e9f64b53071ef75eca2420459c270',
     armv7l: '475b434d8a0c408beb0dd6eae1cc56a2915e9f64b53071ef75eca2420459c270',
     x86_64: '172b094e0a4a14f9cf6ce8abe064718ea081a90e55d9048784e19c8c6d4d4c15'
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
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
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
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'librevenge' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'libsm' # R
  depends_on 'libvisio' # R
  depends_on 'libwpg' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxml2' # R
  depends_on 'libxslt' # R
  depends_on 'llvm_lib' => :build
  depends_on 'pangomm_1_4' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'popt' => :build
  depends_on 'potrace' # R
  depends_on 'py3_cython' => :build
  depends_on 'readline' # R
  depends_on 'zlib' # R

  gnome

  cmake_options '-DWITH_GRAPHICS_MAGICK=ON \
            -DWITH_INTERNAL_2GEOM=ON \
            -DWITH_MANPAGE_COMPRESSION=OFF \
            -DWITH_X11=ON'

  def self.postinstall
    ExitMessage.add "\nType 'inkscape' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/inkscape")
  end
end
