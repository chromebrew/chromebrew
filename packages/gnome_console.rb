# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'package'

class Gnome_console < Package
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  version '43.0'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/43.0_armv7l/gnome_console-43.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/43.0_armv7l/gnome_console-43.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/43.0_i686/gnome_console-43.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/43.0_x86_64/gnome_console-43.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a17b89319b29ee05699060f1081fd1a696f459d7b9667c1d72e47475bfcf9b91',
     armv7l: 'a17b89319b29ee05699060f1081fd1a696f459d7b9667c1d72e47475bfcf9b91',
       i686: '6c60da06b547cc5988c88b4e69fc6f8f725bd8a948ae46800735f5a8c0c5d599',
     x86_64: '16dde8210402c103df444487e6e6837be5f1cc5a231db07b6596cc5b97317697'
  })

  depends_on 'libgtop'
  depends_on 'libhandy'
  depends_on 'vte'
  depends_on 'sassc' => :build
  depends_on 'nautilus' => :build
  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'vulkan_icd_loader' # R

  gnome

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
