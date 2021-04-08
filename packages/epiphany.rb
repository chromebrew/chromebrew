# Adapted from Arch Linux epiphany PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/epiphany/trunk/PKGBUILD

require 'package'

class Epiphany < Package
  description 'A GNOME web browser based on the WebKit rendering engine'
  homepage 'https://wiki.gnome.org/Apps/Web'
  version '40.0'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  case ARCH
  when 'x86_64', 'aarch64', 'armv7l'
    source_url "https://gitlab.gnome.org/GNOME/epiphany/-/archive/#{version}/epiphany-#{version}.tar.bz2"
    source_sha256 '2603fcc30ea8c2ba1343eda845c70825af0749db1c5e1ef252240e30dd855c06'
  end

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/epiphany-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/epiphany-40.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/epiphany-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '8985d22d9a78b08b3a8419acb4e9b808e2a1b4295c8d718a48cc9425025b6ca2',
     armv7l: '8985d22d9a78b08b3a8419acb4e9b808e2a1b4295c8d718a48cc9425025b6ca2',
     x86_64: '16990d7104da6872cfeb93f5fcbbc184d2d22f476dd544af848b22196f9facd0'
  })

  depends_on 'atk'
  depends_on 'cairo' => :build
  depends_on 'docbook_xml' => ':build'
  depends_on 'freetype' => :build
  depends_on 'gcr'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'gtk3'
  depends_on 'help2man' => :build
  depends_on 'json_glib'
  depends_on 'libarchive'
  depends_on 'libdazzle'
  depends_on 'libhandy'
  depends_on 'libportal'
  depends_on 'libsecret'
  depends_on 'libsoup2'
  depends_on 'lsb_release' => ':build'
  depends_on 'pango'
  depends_on 'startup_notification' => ':build'
  depends_on 'webkit2gtk_4'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
