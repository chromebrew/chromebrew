# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'package'

class Gnome_console < Package
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  version '44.beta'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta_armv7l/gnome_console-44.beta-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta_armv7l/gnome_console-44.beta-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta_i686/gnome_console-44.beta-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta_x86_64/gnome_console-44.beta-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dbc14ab6922e47d06f754ce71bc56c9a92b5f6327dbf68a70e71a847415a3a1e',
     armv7l: 'dbc14ab6922e47d06f754ce71bc56c9a92b5f6327dbf68a70e71a847415a3a1e',
       i686: 'ba4c9c384b6d4ef0d8e25388fe17b133bf336f7101c9791ad16935bc901deb60',
     x86_64: '406c3d4f67aacc9824f5fe69a62bd356ee8230b4eb5c55e41fdd2c1ac6ee6d0f'
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
