require 'package'

class Gimp < Package
  description 'GIMP is a cross-platform image editor available for GNU/Linux, OS X, Windows and more operating systems.'
  homepage 'https://www.gimp.org/'
  version '2.10.32'
  license 'GPL-3 and LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/gimp/v2.10/gimp-2.10.32.tar.bz2'
  source_sha256 '3f15c70554af5dcc1b46e6dc68f3d8f0a6cc9fe56b6d78ac08c0fd859ab89a25'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.32_armv7l/gimp-2.10.32-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.32_armv7l/gimp-2.10.32-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.32_i686/gimp-2.10.32-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gimp/2.10.32_x86_64/gimp-2.10.32-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c07455d117cb5401425eb1da195c49084949b35228b33e00b8e162e1a4c37978',
     armv7l: 'c07455d117cb5401425eb1da195c49084949b35228b33e00b8e162e1a4c37978',
       i686: 'da489078f0e946f11e2ac57111b37f6dbca73fdf9c591d1b2fa23150769d02d1',
     x86_64: 'fa589a17ab1af432be4de739a2597d8df992d4573b7a3ebaffee073160acdb43'
  })

  depends_on 'aalib' # R
  depends_on 'alsa_lib' # R
  depends_on 'appstream_glib' # R
  depends_on 'atk' => :build
  depends_on 'babl' # R
  depends_on 'bz2' # R
  depends_on 'cairo' # R
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'gegl' # R
  depends_on 'gexiv2' # R
  depends_on 'ghostscript' # R
  depends_on 'gjs' => :build
  depends_on 'glibc' # R
  depends_on 'glib_networking'
  depends_on 'glib' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'ilmbase' # R
  depends_on 'iso_codes' # R
  depends_on 'jsonc' => :build
  depends_on 'json_glib' # R
  depends_on 'lcms' # R
  depends_on 'libarchive' # R
  depends_on 'libavif' => :build
  depends_on 'libexif' => :build
  depends_on 'libgudev' # R
  depends_on 'libheif' => :build
  depends_on 'libice' => :build
  depends_on 'libjpeg' # R
  depends_on 'libjxl' # R
  depends_on 'libmng' # R
  depends_on 'libmypaint' # R
  depends_on 'libpng' # R
  depends_on 'librsvg' # R
  depends_on 'libsm' => :build
  depends_on 'libtiff' # R
  depends_on 'libunwind' # R
  depends_on 'libwebp' # R
  depends_on 'libwmf' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxmu' # R
  depends_on 'libxpm' # R
  depends_on 'libxt' => :build
  depends_on 'luajit' => :build
  depends_on 'luajit_lgi' => :build
  depends_on 'mypaint_brushes_1' => :build
  depends_on 'openexr' # R
  depends_on 'openjpeg' # R
  depends_on 'pango' # R
  depends_on 'poppler_data'
  depends_on 'poppler' # R
  depends_on 'py2_pycairo' => :build
  depends_on 'pygtk' => :build
  depends_on 'python2' => :build
  depends_on 'shared_mime_info' => :build
  depends_on 'webkit2gtk' # R
  depends_on 'xdg_base' => :build
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

  gnome

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
