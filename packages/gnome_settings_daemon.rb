require 'buildsystems/meson'

class Gnome_settings_daemon < Meson
  description 'GNOME Settings Daemon'
  homepage 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon'
  version '46.rc'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'x86_64 aarch64 armv7l' # not compatible with i686 upstream
  source_url 'https://gitlab.gnome.org/GNOME/gnome-settings-daemon.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'deaf3ac2235aa02689caeb7bc4ff86d341e37101da32f9714af0e54049ebb22d',
     armv7l: 'deaf3ac2235aa02689caeb7bc4ff86d341e37101da32f9714af0e54049ebb22d',
     x86_64: '97ba6e1783736d5ea0046ea1e4a2e441a91c2921ba87d2ab11727d3bdb0ad1ef'
  })

  depends_on 'colord' => :build
  depends_on 'dconf' => :build
  depends_on 'gnome_desktop' => :build
  depends_on 'gsettings_desktop_schemas' => :build
  depends_on 'libcanberra' => :build
  depends_on 'libnotify' => :build
  depends_on 'libxfixes' # R
  depends_on 'libxslt' => :build
  depends_on 'networkmanager' => :build
  depends_on 'nss' => :build
  depends_on 'docbook_xsl' => :build
  depends_on 'geocode_glib' => :build
  depends_on 'polkit' => :build
  depends_on 'upower' => :build
  depends_on 'libgweather' => :build
  depends_on 'elogind' => :build
  depends_on 'geoclue' => :build
  depends_on 'gcr' => :build
  depends_on 'upower' => :build
  depends_on 'alsa_lib' => :build
  depends_on 'cups' => :build
  depends_on 'gcr_4' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'glib' => :build
  depends_on 'glibc' => :build
  depends_on 'gtk3' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'libgudev' => :build
  depends_on 'libwacom' => :build
  depends_on 'libx11' => :build
  depends_on 'libxext' => :build
  depends_on 'libxi' => :build
  depends_on 'modemmanager' => :build
  depends_on 'networkmanager' => :build
  depends_on 'nss' => :build
  depends_on 'pango' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'wayland' => :build

  gnome

  meson_options '-Dsystemd=false \
    -Dcolord=false'
    
  def self.patch
    system "sed -i '/libsystemd_dep/d' meson.build"
    system "sed -i '/libsystemd_dep/d' plugins/sharing/meson.build"
  end
end
