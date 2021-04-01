require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://wiki.gnome.org/Projects/Mutter'
  version '40.0'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://gitlab.gnome.org/GNOME/mutter/-/archive/#{version}/mutter-#{version}.tar.bz2"
  source_sha256 '3f56768113d536f5842ea6db14d1d9c48f8c87cd240891f9b9305116e425771e'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4738981bc3b25f189e376e9398f892063e4434881b364abfb471ae2671c5518c',
     armv7l: '4738981bc3b25f189e376e9398f892063e4434881b364abfb471ae2671c5518c',
     x86_64: '245503f395c5a138e279d71fee7bdd98b2244bc682a90a373f742a3b78f190f2'
  })

  depends_on 'dconf'
  depends_on 'gnome_settings_daemon'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'gobject_introspection' => :build
  depends_on 'xorg_server' => :build
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
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
