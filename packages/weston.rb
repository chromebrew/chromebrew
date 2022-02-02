require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  @_ver = '10.0.0'
  version @_ver
  license 'MIT and CC-BY-SA-3.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/weston.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/10.0.0_armv7l/weston-10.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/10.0.0_armv7l/weston-10.0.0-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/10.0.0_i686/weston-10.0.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/10.0.0_x86_64/weston-10.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cd733a24b9f957d1ee7fc3295ad39fa71d3af7088f89c487cb377cc5bc7bd09c',
     armv7l: 'cd733a24b9f957d1ee7fc3295ad39fa71d3af7088f89c487cb377cc5bc7bd09c',
    i686: 'c2e647df4ea31290175675df85549b8d1e44598a77e6938346b25fd2de7c04af',
  x86_64: 'bc09f27481eb8da5f81d1f8dc9d522f747f2890d24d9d81ca672e26a756badbe'
  })

  depends_on 'harfbuzz'
  depends_on 'graphite'
  depends_on 'libxcursor'
  depends_on 'libinput'
  depends_on 'libxkbcommon'
  depends_on 'wayland_protocols'
  depends_on 'libjpeg'
  depends_on 'libunwind'
  depends_on 'pango'
  depends_on 'dbus'
  depends_on 'libxxf86vm'
  depends_on 'llvm' => :build
  depends_on 'xdg_base'
  depends_on 'libwebp'
  depends_on 'libva'
  depends_on 'gstreamer'
  depends_on 'gst_plugins_base'
  depends_on 'libwacom'

  def self.build
    system "LIBRARY_PATH=#{CREW_LIB_PREFIX} meson #{CREW_MESON_OPTIONS} \
        -Dshell-ivi=false \
        -Dremoting=true \
        -Dbackend-default=wayland \
        -Dbackend-drm=true \
        -Dpipewire=false \
        -Dcolor-management-colord=false \
        -Dcolor-management-lcms=false \
        -Dbackend-rdp=false \
        -Dlauncher-logind=false \
        -Ddeprecated-weston-launch=true \
        -Dsystemd=false \
        -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland \
        builddir"

    system 'meson configure builddir'
    system 'ninja -C builddir'
    system "cat <<'EOF'> weston.ini
[core]
xwayland=true

[terminal]
font=Cousine
EOF"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja install -C builddir"
    system "install -Dm644 weston.ini #{CREW_DEST_HOME}/.config/weston.ini"
  end

  def self.postinstall
    puts
    puts 'To run weston with xwayland try something like this:'.lightblue
    puts 'export WAYLAND_DISPLAY=wayland-1'.lightblue
    puts 'WAYLAND_DISPLAY=wayland-0 weston -Swayland-1 --xwayland'.lightblue
    puts
  end
end
