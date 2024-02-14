require 'buildsystems/meson'

class Mutter < Meson
  description 'A window manager for GNOME'
  homepage 'https://wiki.gnome.org/Projects/Mutter'
  version '45.4'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64' # No longer supported for i686 upstream
  source_url 'https://gitlab.gnome.org/GNOME/mutter.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51616723ce4f1abb0c70764cec24ef81a79bbb07ce04aa5b5e5a0dad1f9ef83d',
     armv7l: '51616723ce4f1abb0c70764cec24ef81a79bbb07ce04aa5b5e5a0dad1f9ef83d',
     x86_64: 'f7b3b24b155fcfb1041f59fff0585a94493917f8cd3771111c9a5d9bd7cb3cb4'
  })

  # depends_on 'ccache' => :build
  depends_on 'dconf'
  depends_on 'gnome_settings_daemon'
  depends_on 'gobject_introspection' => :build
  depends_on 'gsettings_desktop_schemas'
  depends_on 'libcanberra'
  depends_on 'libei'
  depends_on 'libinput'
  depends_on 'libwacom'
  depends_on 'pipewire'
  depends_on 'startup_notification'
  depends_on 'xorg_server' => :build
  depends_on 'xwayland'

  meson_options "-Dtests=false \
    -Dprofiler=false \
    -Dopengl=true \
    -Dglx=true \
    -Dsystemd=false \
    -Dwayland=true \
    -Dnative_backend=true \
    -Dcogl_tests=true \
    -Dxwayland_path=#{CREW_PREFIX}/bin/Xwayland"
end
