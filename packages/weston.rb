# frozen_string_literal: true

require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  @_ver = '11.0.0'
  version @_ver
  license 'MIT and CC-BY-SA-3.0'
  compatibility 'x86_64 armv7l aarch64'
  source_url 'https://gitlab.freedesktop.org/wayland/weston.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/11.0.0_armv7l/weston-11.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/11.0.0_armv7l/weston-11.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/11.0.0_x86_64/weston-11.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cd09b1e0ea468162fc3f4f41befc8b5c01bb22861071e5943011a4fdbf93fb23',
     armv7l: 'cd09b1e0ea468162fc3f4f41befc8b5c01bb22861071e5943011a4fdbf93fb23',
     x86_64: 'e7573ade9cf4dfd6f944dc1a0c467afc7b5abe26ba443a6e1cd832e79f2e45e2'
  })

  depends_on 'dbus'
  depends_on 'eudev' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphite'
  depends_on 'gstreamer' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libevdev' # R
  depends_on 'libinput' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libunwind'
  depends_on 'libva' # R
  depends_on 'libwacom'
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcursor'
  depends_on 'libxcursor' # R
  depends_on 'libxkbcommon'
  depends_on 'libxkbcommon' # R
  depends_on 'libxxf86vm'
  depends_on 'llvm' => :build
  depends_on 'mesa' # R
  depends_on 'pango' # R
  depends_on 'pixman' # R
  depends_on 'seatd' # R
  depends_on 'wayland_protocols'
  depends_on 'xdg_base'
  depends_on 'libglvnd' # R
  depends_on 'wayland' # R

  def self.build
    system "LIBRARY_PATH=#{CREW_LIB_PREFIX} meson setup #{CREW_MESON_OPTIONS} \
        -Dshell-ivi=false \
        -Dremoting=true \
        -Dbackend-default=wayland \
        -Dbackend-drm=true \
        -Dpipewire=false \
        -Dcolor-management-lcms=false \
        -Dbackend-rdp=false \
        -Dlauncher-logind=false \
        -Dlauncher-libseat=true \
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
