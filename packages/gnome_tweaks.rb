require 'package'

class Gnome_tweaks < Package
  description 'Graphical interface for advanced GNOME 3 settings Tweak Tool'
  @_ver = '40.8-43f5bd'
  version @_ver
  license 'GPL-3+ and CC0-1.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-tweaks.git'
  git_branch 'gnome-40'
  git_hashtag '43f5bd133289a90012726f2a5796a92547e7d24a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/40.8-43f5bd_armv7l/gnome_tweaks-40.8-43f5bd-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/40.8-43f5bd_armv7l/gnome_tweaks-40.8-43f5bd-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_tweaks/40.8-43f5bd_x86_64/gnome_tweaks-40.8-43f5bd-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'de82ca077fc6ff11f34bf3a7df1b62cb7fb47a2efd4fce85194164a31537643c',
     armv7l: 'de82ca077fc6ff11f34bf3a7df1b62cb7fb47a2efd4fce85194164a31537643c',
     x86_64: '00f4110c8ca385922da7060d0d14ec3552a2e6a626c80d3817f2f640305925cd'
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

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
  end
end
