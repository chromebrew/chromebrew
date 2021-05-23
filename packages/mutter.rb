require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://wiki.gnome.org/Projects/Mutter'
  version '40.1'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/mutter.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/40.1_armv7l/mutter-40.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/40.1_armv7l/mutter-40.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/40.1_x86_64/mutter-40.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '45b333676e45c13fdeab755581875203cf3f1f23265b86c83db5933e6d80d937',
     armv7l: '45b333676e45c13fdeab755581875203cf3f1f23265b86c83db5933e6d80d937',
     x86_64: 'faf3da0f7e8868fdc885b822ce9fb23bb44e0df47a3f0174c19dc7caff9f6c68'
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
