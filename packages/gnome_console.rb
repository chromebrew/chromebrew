# Adapted from Arch Linux gnome-console PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=gnome-console

require 'package'

class Gnome_console < Package
  description 'A simple user-friendly terminal emulator for the GNOME desktop'
  homepage 'https://gitlab.gnome.org/GNOME/console'
  @_ver = '44.0'
  version "#{@_ver}-1"
  license 'GPL3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/console.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ab2ae3fe6ae44c24c64f2798f45d465c48b4116f530e975bfa967af3bd23a1e',
     armv7l: '1ab2ae3fe6ae44c24c64f2798f45d465c48b4116f530e975bfa967af3bd23a1e',
     x86_64: 'f66c46cdf1a783f685240ba195232e5056db5de64b37994e7e2701fa870f7adc'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libadwaita' # R
  depends_on 'libgtop' # R
  depends_on 'libhandy' => :build
  depends_on 'nautilus' => :build
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'sassc' => :build
  depends_on 'vte' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R

  def self.build
    system "mold -run meson setup #{CREW_MESON_OPTIONS} \
    builddir"
    system 'meson configure --no-pager builddir'
    system "mold -run #{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
