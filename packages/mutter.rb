require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://wiki.gnome.org/Projects/Mutter'
  version '40.3'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/mutter.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/40.3_armv7l/mutter-40.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/40.3_armv7l/mutter-40.3-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/40.3_x86_64/mutter-40.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ad5d9c51bd569a9a6a06fecf2075eb63ed70817f4c29abf7ececbceeb50fe7d4',
     armv7l: 'ad5d9c51bd569a9a6a06fecf2075eb63ed70817f4c29abf7ececbceeb50fe7d4',
     x86_64: 'd1427dea256c51647c61f7e1d8987fe4ce87aee6d98c79993bdaf5657f74b186'
  })

  depends_on 'ccache' => :build
  depends_on 'dconf'
  depends_on 'gnome_settings_daemon'
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libcanberra'
  depends_on 'libinput'
  depends_on 'libwacom'
  depends_on 'pipewire'
  depends_on 'startup_notification'
  depends_on 'xorg_server' => :build
  depends_on 'xwayland'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dtests=false \
    -Dprofiler=false \
    -Dopengl=true \
    -Dglx=true \
    -Dwayland=true \
    -Dnative_backend=true \
    -Dcogl_tests=true \
    -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
