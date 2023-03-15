# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'package'

class Gnome_console < Package
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  @_ver = '44.beta'
  version "#{@_ver}-1"
  license 'GPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta-1_armv7l/gnome_console-44.beta-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta-1_armv7l/gnome_console-44.beta-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_console/44.beta-1_x86_64/gnome_console-44.beta-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '93d882c703a0f53035783ce30ce5cb0db6fd553eebd1fc18bb69bcd88399f8bc',
     armv7l: '93d882c703a0f53035783ce30ce5cb0db6fd553eebd1fc18bb69bcd88399f8bc',
     x86_64: '13cdea3dc6b049f7defc8aed6735e16c66eb74c08688b47aad6504dafd4cb190'
  })

  depends_on 'gcc' # R
  depends_on 'gdk_pixbuf' # L
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' => :build
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' => :build
  depends_on 'libadwaita' # R
  depends_on 'libgtop' # R
  depends_on 'libhandy' => :build
  depends_on 'nautilus' => :build
  depends_on 'pango' # R
  depends_on 'pcre2' => :build
  depends_on 'sassc' => :build
  depends_on 'vte' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # L

  gnome

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
