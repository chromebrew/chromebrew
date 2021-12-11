require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  @_ver = '9.0.0'
  version "#{@_ver}-2"
  license 'MIT and CC-BY-SA-3.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/weston.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/9.0.0-2_armv7l/weston-9.0.0-2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/9.0.0-2_armv7l/weston-9.0.0-2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/9.0.0-2_i686/weston-9.0.0-2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/9.0.0-2_x86_64/weston-9.0.0-2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f6636182e1d0bbb228011c37f14691e3c8bb7481368f7a6841f3bc423cd78716',
     armv7l: 'f6636182e1d0bbb228011c37f14691e3c8bb7481368f7a6841f3bc423cd78716',
       i686: 'd43eb4eb14948ed70fdbd37da6ec3f91f2195c83471bc53d639c16a4298a4702',
     x86_64: '10d807d0a7e218f9e8db4c105bd96512968bbc1b077c6538bf10e15b328aa877'
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
        -Dweston-launch=false \
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
