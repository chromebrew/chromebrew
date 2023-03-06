require 'package'

class Gnome_autoar < Package
  description 'Automatic archives creating and extracting library'
  homepage 'https://wiki.gnome.org/TingweiLan/GSoC2013Final'
  @_ver = '0.4.3'
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-autoar/-/archive/#{@_ver}/gnome-autoar-#{@_ver}.tar.bz2"
  source_sha256 'c1331da864affe666ccaf70788380665d1636f9d3e414ee74e072462a69a6f33'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3-1_armv7l/gnome_autoar-0.4.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3-1_armv7l/gnome_autoar-0.4.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3-1_i686/gnome_autoar-0.4.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3-1_x86_64/gnome_autoar-0.4.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '46c212fe9d8d07407f9a6e584ca59aec9203fb5f7da916eaf9ac2524eba5398c',
     armv7l: '46c212fe9d8d07407f9a6e584ca59aec9203fb5f7da916eaf9ac2524eba5398c',
       i686: 'd84704ef7a74328c5936126742b27546a2bf65a7952475fe86a32e44fad7eccb',
     x86_64: 'f5171c23c19d2f72ad51152def99143cb502b99c41d1ec850e1cdb6e741dd349'
  })

  depends_on 'atk_spi2_core'
  depends_on 'autoconf_archive' => :build
  depends_on 'cairo'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz'
  depends_on 'libarchive'
  depends_on 'libjpeg'
  depends_on 'pango'
  depends_on 'vala' => :build
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
