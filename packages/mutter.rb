require 'package'

class Mutter < Package
  description 'A window manager for GNOME'
  homepage 'https://wiki.gnome.org/Projects/Mutter'
  version '41.0'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64' # No longer supported for i686 upstream
  source_url 'https://gitlab.gnome.org/GNOME/mutter.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/41.0_armv7l/mutter-41.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/41.0_armv7l/mutter-41.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/mutter/41.0_x86_64/mutter-41.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '584f9f6e7413fcc037f6062dd3dba29d356556a58d0206b0401b3c4d34594352',
     armv7l: '584f9f6e7413fcc037f6062dd3dba29d356556a58d0206b0401b3c4d34594352',
     x86_64: '1dbf561eb457bb72023362e41f995c7820fb5c5b899a1f157e43a5722531dbe7'
  })

  # depends_on 'ccache' => :build
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
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dtests=false \
    -Dprofiler=false \
    -Dopengl=true \
    -Dglx=true \
    -Dsystemd=false \
    -Dwayland=true \
    -Dnative_backend=true \
    -Dcogl_tests=true \
    -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland \
    builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
