require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/mutter'
  version '40.rc'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/mutter/-/archive/#{version}/mutter-#{version}.tar.bz2"
  # source_url "https://download.gnome.org/core/#{version}/sources/mutter-#{version}.tar.xz"
  source_sha256 '8652c2d4c95a845d26b37d8fc8edbfa1261273405317103dbc3216d1ee66db99'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.rc-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.rc-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.rc-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7432e3824c27a0f92351e7f9888ddba7416b0513ec6e103bffa9f2f6a70b01bd',
     armv7l: '7432e3824c27a0f92351e7f9888ddba7416b0513ec6e103bffa9f2f6a70b01bd',
     x86_64: 'bc61662e93ad4e540f957efce8b3af3183422b19b838f87878931e9e35a87dd5'
  })

  depends_on 'dconf'
  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'xorg_server' => ':build'
  depends_on 'libinput'
  depends_on 'libwacom'
  depends_on 'startup_notification'
  depends_on 'pipewire'
  depends_on 'libcanberra'
  depends_on 'ccache' => :build

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
