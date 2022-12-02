require 'package'

class Gnome_tweaks < Package
  description 'Graphical interface for advanced GNOME 3 settings Tweak Tool'
  @_ver = '42.beta-354007f'
  version "#{@_ver}-py3.11"
  license 'GPL-3+ and CC0-1.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-tweaks.git'
  git_hashtag '354007f8c2084d7d05436af8776ab0fe63a78bfd'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/42.beta-354007f-py3.11_armv7l/gnome_tweaks-42.beta-354007f-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/42.beta-354007f-py3.11_armv7l/gnome_tweaks-42.beta-354007f-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/42.beta-354007f-py3.11_i686/gnome_tweaks-42.beta-354007f-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/42.beta-354007f-py3.11_x86_64/gnome_tweaks-42.beta-354007f-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '361a7d7370dabe66b16e555ce495053ee830077bcdfbec13adb5b8262a3ddab2',
     armv7l: '361a7d7370dabe66b16e555ce495053ee830077bcdfbec13adb5b8262a3ddab2',
       i686: 'f70d4b1921fb9e0d060a2bbf5f42e20b17b64a033176f733f1e73d97e4422dd9',
     x86_64: 'ebc438a4759458770ad86e66782150d9d9713f881b26b01b02fa346a6d6ce6ed'
  })

  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'pygobject'
  depends_on 'python3'
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
