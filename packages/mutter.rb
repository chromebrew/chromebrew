require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://gitlab.gnome.org/GNOME/mutter'
  version '40.beta'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://download.gnome.org/core/40/#{version}/sources/mutter-#{version}.tar.xz"
  source_sha256 '22aa7f8a57dbef865bc4e9b88f8fb91f45f18157d70f218199238bc10c25b1a6'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.beta-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.beta-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mutter-40.beta-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6120122d259d3309e5244e06d793d67c7f41327ab1c177422adf0940c1f58c72',
     armv7l: '6120122d259d3309e5244e06d793d67c7f41327ab1c177422adf0940c1f58c72',
     x86_64: '213c59512a34b6fdc0f2e3f709be654c826742dc50ef20e3d796d92188914900'
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
