require 'package'

class Gnome_autoar < Package
  description 'Automatic archives creating and extracting library'
  homepage 'https://wiki.gnome.org/TingweiLan/GSoC2013Final'
  @_ver = '0.4.3'
  version @_ver.to_s
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gnome-autoar/-/archive/#{@_ver}/gnome-autoar-#{@_ver}.tar.bz2"
  source_sha256 'c1331da864affe666ccaf70788380665d1636f9d3e414ee74e072462a69a6f33'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3_armv7l/gnome_autoar-0.4.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3_armv7l/gnome_autoar-0.4.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3_i686/gnome_autoar-0.4.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.3_x86_64/gnome_autoar-0.4.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2e815d2b4b8705de7158f6606ed1bdca38086c86d4a9c5ff7481a845c9443d2f',
     armv7l: '2e815d2b4b8705de7158f6606ed1bdca38086c86d4a9c5ff7481a845c9443d2f',
       i686: '7c3022e0ab07ad9f31339737f51958c2895cf70707fe1c45efad9aadb1a83717',
     x86_64: 'f9500ad0e497a667e625edad533581d1fa731dc56d94bf91f9cceaac65ae64cd'
  })

  depends_on 'atk'
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
    system "meson #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
