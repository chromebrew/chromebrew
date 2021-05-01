require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.10.24'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/gimp/v2.10/gimp-2.10.24.tar.bz2'
  source_sha256 'bd1bb762368c0dd3175cf05006812dd676949c3707e21f4e6857435cb435989e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.24_armv7l/gimp-2.10.24-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.24_armv7l/gimp-2.10.24-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.24_i686/gimp-2.10.24-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.24_x86_64/gimp-2.10.24-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6867db24428a1509ac14459f29944a2fbb0a81e8a509b39cd2b7c837fd48fd00',
     armv7l: '6867db24428a1509ac14459f29944a2fbb0a81e8a509b39cd2b7c837fd48fd00',
       i686: '6e8faf363dca5a4ae3e1f9eedf05c771016c24256ee67df5a39c586fe565ff0d',
     x86_64: 'a930aebb265c21d07c8ed0d3e754ca60fe98232335089647d49b294832cdd3d4'
  })

  depends_on 'aalib'
  depends_on 'alsa_lib'
  depends_on 'atk'
  depends_on 'babl'
  depends_on 'cairo'
  depends_on 'ffmpeg'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'gegl'
  depends_on 'gexiv2'
  depends_on 'ghostscript'
  depends_on 'gjs'
  depends_on 'glib'
  depends_on 'glib_networking'
  depends_on 'gtk2'
  depends_on 'harfbuzz'
  depends_on 'ilmbase'
  depends_on 'jsonc'
  depends_on 'json_glib'
  depends_on 'lcms'
  depends_on 'libavif'
  depends_on 'libexif'
  depends_on 'libgudev'
  depends_on 'libheif'
  depends_on 'libice'
  depends_on 'libjpeg'
  depends_on 'libmng'
  depends_on 'libmypaint'
  depends_on 'libpng'
  depends_on 'librsvg'
  depends_on 'libsm'
  depends_on 'libtiff'
  depends_on 'libunwind'
  depends_on 'libwebp'
  depends_on 'libwmf'
  depends_on 'libx11'
  depends_on 'libxcursor'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxmu'
  depends_on 'libxpm'
  depends_on 'libxt'
  depends_on 'mypaint_brushes'
  depends_on 'openexr'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'poppler'
  depends_on 'poppler_data'
  depends_on 'pygtk'
  depends_on 'shared_mime_info'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    system "env CFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      CXXFLAGS='-pipe -flto=auto -fuse-ld=gold' \
      LDFLAGS='-flto' \
      LIBS='-lm' \
      datarootdir=#{CREW_PREFIX}/share \
      ./configure \
      #{CREW_OPTIONS} \
      --with-icc-directory=#{CREW_PREFIX}/share/color/icc \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
