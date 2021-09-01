require 'package'

class Gnome_tweaks < Package
  description 'Graphical interface for advanced GNOME 3 settings Tweak Tool'
  @_ver = '40.0'
  version @_ver
  license 'GPL-3+ and CC0-1.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-tweaks.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/40.0_armv7l/gnome_tweaks-40.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/40.0_armv7l/gnome_tweaks-40.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/40.0_x86_64/gnome_tweaks-40.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ebec11a3439e8cd1817f871c2f2015ebce581a483a1926cc5dcbf42c55ae1145',
     armv7l: 'ebec11a3439e8cd1817f871c2f2015ebce581a483a1926cc5dcbf42c55ae1145',
     x86_64: 'a002b3463df0c990e3cab84ae1a9748eddaa8d50e9952b04d593cd99373578f9'
  })

  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'py3_gobject'
  depends_on 'libhandy'
  depends_on 'libnotify'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
