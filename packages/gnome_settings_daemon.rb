# Deprecated: Newer versions are no longer compatible with Chromebrew due to dependence on systemd.

require 'package'

class Gnome_settings_daemon < Package
  description 'GNOME Settings Daemon'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon'
  version '43.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l' # not compatible with i686 upstream
  source_url 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon.git'
  git_hashtag version
  binary_compression 'tar.zst'

  deprecated

  binary_sha256({
    aarch64: 'deaf3ac2235aa02689caeb7bc4ff86d341e37101da32f9714af0e54049ebb22d',
     armv7l: 'deaf3ac2235aa02689caeb7bc4ff86d341e37101da32f9714af0e54049ebb22d',
     x86_64: '97ba6e1783736d5ea0046ea1e4a2e441a91c2921ba87d2ab11727d3bdb0ad1ef'
  })

  depends_on 'colord'
  depends_on 'dconf'
  depends_on 'gnome_desktop'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libcanberra'
  depends_on 'libnotify'
  depends_on 'libxfixes' # R
  depends_on 'libxslt' => :build
  depends_on 'networkmanager' => :build
  depends_on 'nss' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'geocode_glib'
  depends_on 'polkit'
  depends_on 'upower'
  depends_on 'libgweather'
  depends_on 'elogind'
  depends_on 'geoclue'
  depends_on 'gcr'
  depends_on 'upower' # R
  depends_on 'alsa_lib' # R
  depends_on 'cups' # R
  depends_on 'gcr_4' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libgudev' # R
  depends_on 'libwacom' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxi' # R
  depends_on 'modemmanager' # R
  depends_on 'networkmanager' # R
  depends_on 'nss' # R
  depends_on 'pango' # R
  depends_on 'pulseaudio' # R
  depends_on 'wayland' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dsystemd=false \
    -Dcolord=false \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
