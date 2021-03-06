require 'package'

class Gnome_tweaks < Package
  description 'Graphical interface for advanced GNOME 3 settings Tweak Tool'
  @_ver = '40.beta'
  version @_ver
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/gnome-tweaks/-/archive/#{@_ver}/gnome-tweaks-#{@_ver}.tar.bz2"
  source_sha256 'b274a4a9bf93405bd487f5a2bb93fc15bfe0312b21dbebfe5088b8d477d63416'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_tweaks-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_tweaks-40.beta-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnome_tweaks-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fb04b6ae9e7bc37672bd78e1c4776d98d4b0e9dce170d0c68efbb06cc779b684',
     armv7l: 'fb04b6ae9e7bc37672bd78e1c4776d98d4b0e9dce170d0c68efbb06cc779b684',
     x86_64: 'b6088a18bd9568a8b6c6a6f983e85e3e8df5efc084283035eff6b6d5cbbe2f28'
  })

  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'pygobject'
  depends_on 'libhandy1'
  depends_on 'libnotify'

  def self.build
    system "meson setup #{CREW_MESON_LTO_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
