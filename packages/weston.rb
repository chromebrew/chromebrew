require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  @_ver = '9.0.0'
  version "#{@_ver}-1"
  compatibility 'all'
  source_url "https://github.com/wayland-project/weston/archive/#{@_ver}.tar.gz"
  source_sha256 '82b17ab1766f13557fc620c21e3c89165342d3a3ead79ba01181b4f7d2144487'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/weston-9.0.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/weston-9.0.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/weston-9.0.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/weston-9.0.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9f5f48dfa122850c5a1041ae59c8358d76eb08adb84be474dba2cfdf430074ea',
     armv7l: '9f5f48dfa122850c5a1041ae59c8358d76eb08adb84be474dba2cfdf430074ea',
       i686: '1a3cfca6a5b69500859b5af32fb22b3c9539804df6d0995564a21bb6a4f89f37',
     x86_64: '4c729aa9b4c39a9016bc3a69bd9e41c0ab3dd12466128a1f04c3e735b2206d12'
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
    system "LIBRARY_PATH=#{CREW_LIB_PREFIX} meson #{CREW_MESON_LTO_OPTIONS} \
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
