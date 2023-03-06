require 'package'

class Inkscape < Package
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '1.2.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://inkscape.org/gallery/item/37360/inkscape-1.2.2.tar.xz'
  source_sha256 'a0c7fd0d03c0a21535e648ef301dcf80dd7cfc1f3545e51065fbf1ba3ee8a5c4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2_armv7l/inkscape-1.2.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2_armv7l/inkscape-1.2.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2_i686/inkscape-1.2.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2_x86_64/inkscape-1.2.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c4ef578261aa1fcea6cbaae949671af0146402ff3d872a769296c671df07c101',
     armv7l: 'c4ef578261aa1fcea6cbaae949671af0146402ff3d872a769296c671df07c101',
       i686: 'f0e8eade7b45ccd509a65f6e0e4847fccfbaed568355592a2099e63c32888307',
     x86_64: '529c95134104b67575d8282fe254d2266cd584cb9063604ddb0fc7f28f57eacc'
  })

  depends_on 'atkmm' # R
  depends_on 'atk_spi2_core' # R
  depends_on 'at_spi2_core' # R
  depends_on 'bdwgc' # R
  depends_on 'boost' # R
  depends_on 'cairo' => :build
  depends_on 'cairomm_1_0' # R
  depends_on 'double_conversion' # R
  depends_on 'enchant' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'graphicsmagick' # R
  depends_on 'gsl' # R
  depends_on 'gspell' # R
  depends_on 'gtk3' # R
  depends_on 'gtkmm3' # R
  depends_on 'gtksourceview' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'lcms' # R
  depends_on 'libcdr' # R
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
  depends_on 'llvm' => :build
  depends_on 'pangomm_1_4' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'popt' => :build
  depends_on 'potrace' # R
  depends_on 'readline' # R
  depends_on 'sommelier' => :build
  depends_on 'xdg_base' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "cmake -B builddir #{CREW_CMAKE_OPTIONS} \
            -DWITH_IMAGE_MAGICK=OFF \
            -DWITH_INTERNAL_2GEOM=ON \
            -DWITH_MANPAGE_COMPRESSION=OFF \
            -DWITH_X11=ON \
            -G Ninja"
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
