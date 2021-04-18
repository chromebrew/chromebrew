require 'package'

class Gnome_tweaks < Package
  description 'Graphical interface for advanced GNOME 3 settings Tweak Tool'
  @_ver = '40.beta-4cbb'
  version @_ver
  license 'GPL-3+ and CC0-1.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-tweaks/-/archive/4cbb4a44743b64df5c688e84f28befe28da012ba/gnome-tweaks-4cbb4a44743b64df5c688e84f28befe28da012ba.tar.bz2'
  # source_url "https://gitlab.gnome.org/GNOME/gnome-tweaks/-/archive/#{@_ver}/gnome-tweaks-#{@_ver}.tar.bz2"
  source_sha256 '4b0548176772ce999531f6f873ee147420f9dc95980a11a3c2faa052b76119e5'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gnome_tweaks-40.beta-4cbb-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gnome_tweaks-40.beta-4cbb-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gnome_tweaks-40.beta-4cbb-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gnome_tweaks-40.beta-4cbb-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '490cce3a691eef0f388a464bb18900da5fa1f898a10d2d39fa59d023a89e229e',
     armv7l: '490cce3a691eef0f388a464bb18900da5fa1f898a10d2d39fa59d023a89e229e',
       i686: '16cab78294026cdc82fe297a3e1ec0fb2e9fa918d6e4c5bea75152bf18ead989',
     x86_64: '32c252ce5bc50847b2552a2625dce0aa89f48f568c9d3fc6cdd3e1d4d241fc06'
  })

  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'pygobject'
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
end
