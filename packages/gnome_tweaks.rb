# Deprecated: Newer versions are no longer compatible with Chromebrew due to dependence on systemd.

require 'buildsystems/meson'

class Gnome_tweaks < Meson
  description 'Graphical interface for advanced GNOME 3 settings Tweak Tool'
  homepage 'https://wiki.gnome.org/Apps/Tweaks'
  @_ver = '42.0'
  version "#{@_ver}-py3.12"
  license 'GPL-3+ and CC0-1.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-tweaks.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'
  
  deprecated

  binary_sha256({
    aarch64: '5c5e766fab885a047e4b5bc91b72da3d84844584935e19197ff2da4ac1320e69',
     armv7l: '5c5e766fab885a047e4b5bc91b72da3d84844584935e19197ff2da4ac1320e69',
     x86_64: '10846cf3a86dd7036dcac55934b5429d2fd3ad99b2d47da695929b6ecaa57a21'
  })

  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'pygobject'
  depends_on 'python3'
  depends_on 'libhandy'
  depends_on 'libnotify'
end
