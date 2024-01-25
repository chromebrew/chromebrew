require 'buildsystems/meson'

class Weston < Meson
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  version '13.0.0'
  license 'MIT and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/wayland/weston.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/13.0.0_armv7l/weston-13.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/13.0.0_armv7l/weston-13.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/13.0.0_x86_64/weston-13.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '463fafa09122de01bf4c8dbba4eb157ae9741aa0aec68561e3ef03878d262161',
     armv7l: '463fafa09122de01bf4c8dbba4eb157ae9741aa0aec68561e3ef03878d262161',
     x86_64: 'daacfeb06185e4ff3a0fef2b7845a7b4f2528a02d1569957d5a61a70cc3e5bd2'
  })

  depends_on 'cairo' # R
  depends_on 'dbus' => :build
  depends_on 'eudev' # R
  depends_on 'ffmpeg' # R
  depends_on 'fontconfig' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gmp' # R
  depends_on 'gnutls' # R
  depends_on 'graphite' => :build
  depends_on 'gstreamer' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libevdev' # R
  depends_on 'libglvnd' # R
  depends_on 'libinput' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libunwind'
  depends_on 'libva' # R
  depends_on 'libwacom' => :build
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcursor'
  depends_on 'libxcursor' # R
  depends_on 'libxkbcommon'
  depends_on 'libxkbcommon' # R
  depends_on 'libxxf86vm'
  depends_on 'linux_pam' # R
  depends_on 'mesa' # R
  depends_on 'nettle' # R
  depends_on 'pango' # R
  depends_on 'pipewire' # R
  depends_on 'pixman' # R
  depends_on 'seatd' # R
  depends_on 'wayland_protocols'
  depends_on 'wayland' # R
  depends_on 'xcb_util_cursor' => :build
  depends_on 'xdg_base' => :build
  depends_on 'zlibpkg' # R

  meson_options "-Dbackend-default=wayland \
        -Dbackend-drm=true \
        -Dbackend-rdp=false \
        -Dcolor-management-lcms=false \
        -Dremoting=true \
        -Dshell-ivi=false \
        -Dsystemd=false \
        -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland"

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    File.write 'weston.ini', <<~WESTON_INI_EOF
      [core]
      xwayland=true

      [terminal]
      font=Cousine
    WESTON_INI_EOF
    FileUtils.install 'weston.ini', "#{CREW_DEST_HOME}/.config/weston.ini", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add <<~EOT1.lightblue

      To run weston with xwayland try something like this:
      export WAYLAND_DISPLAY=wayland-1
      WAYLAND_DISPLAY=wayland-0 weston -Swayland-1 --xwayland
    EOT1
  end
end
