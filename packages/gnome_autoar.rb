require 'package'

class Gnome_autoar < Package
  description 'Automatic archives creating and extracting library'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-autoar'
  version '0.4.4'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-autoar.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.4_armv7l/gnome_autoar-0.4.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.4_armv7l/gnome_autoar-0.4.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_autoar/0.4.4_x86_64/gnome_autoar-0.4.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2b2ec52490637bb52ee34c9d454ef16c7c615dce5f1704cb00c8060c04a38f73',
     armv7l: '2b2ec52490637bb52ee34c9d454ef16c7c615dce5f1704cb00c8060c04a38f73',
     x86_64: '075ff1866f197a0d54c5ca5a1ea2d5ccb8a4bed63629500ffb8fae62939f418b'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'autoconf_archive' => :build
  depends_on 'cairo' => :build
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz' # R
  depends_on 'libarchive' # R
  depends_on 'libjpeg' => :build
  depends_on 'pango' # R
  depends_on 'vala' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
