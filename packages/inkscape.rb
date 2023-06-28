require 'package'

class Inkscape < Package
  description 'Inkscape is a professional vector graphics editor for Windows, Mac OS X and Linux.'
  homepage 'https://inkscape.org/'
  version '1.2.2-1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://inkscape.org/gallery/item/37360/inkscape-1.2.2.tar.xz'
  source_sha256 'a0c7fd0d03c0a21535e648ef301dcf80dd7cfc1f3545e51065fbf1ba3ee8a5c4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2-1_armv7l/inkscape-1.2.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2-1_armv7l/inkscape-1.2.2-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/inkscape/1.2.2-1_x86_64/inkscape-1.2.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '05fd2a30bdb8d682774262120e8a70bbc15a699102f59ccd0bfcd2f08245cf3a',
     armv7l: '05fd2a30bdb8d682774262120e8a70bbc15a699102f59ccd0bfcd2f08245cf3a',
     x86_64: '4fa021eb36d4e9fb6d948e63590dd4393f690f08c138b947be3ada7c4ea5d855'
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
  depends_on 'gtksourceview' => :build
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme'
  depends_on 'jemalloc' => :build
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
  depends_on 'llvm16_lib' => :build
  depends_on 'pangomm_1_4' # R
  depends_on 'pango' # R
  depends_on 'poppler' # R
  depends_on 'popt' => :build
  depends_on 'potrace' # R
  depends_on 'py3_cython' => :build
  depends_on 'readline' # R
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
