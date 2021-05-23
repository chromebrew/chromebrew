# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'package'

class Epiphany < Package
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '40.1'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/epiphany.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/epiphany/40.1_armv7l/epiphany-40.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/epiphany/40.1_armv7l/epiphany-40.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/epiphany/40.1_x86_64/epiphany-40.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '141150e042132087d7e1dc8738fae0d35c26f2a337fa969c414eb912c698b13d',
     armv7l: '141150e042132087d7e1dc8738fae0d35c26f2a337fa969c414eb912c698b13d',
     x86_64: 'e0e48fab65f7b75bd9dfb07243a4d14ced036376da71be28eb9491c363b640dd'
  })

  depends_on 'atk' # R
  depends_on 'cairo' # R
  depends_on 'docbook_xml' => :build
  depends_on 'freetype' => :build
  depends_on 'gcr' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'gmp' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk3' # R
  depends_on 'help2man' => :build
  depends_on 'json_glib' # R
  depends_on 'libdazzle' # R
  depends_on 'libhandy' # R
  depends_on 'libportal' # R
  depends_on 'libsecret' # R
  depends_on 'libsoup2' # R
  depends_on 'lsb_release' => :build
  depends_on 'pango' # R
  depends_on 'startup_notification' => :build
  depends_on 'valgrind' => :build
  depends_on 'webkit2gtk_4' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
  end
end
