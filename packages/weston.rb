require 'buildsystems/meson'

class Weston < Meson
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'https://wayland.freedesktop.org'
  version '16.0.0'
  license 'MIT and CC-BY-SA-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/wayland/weston.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a9a7c06d1d16bdb26fe3eb763f918e795efa3856df8409a21bcdf1d51089000',
     armv7l: '4a9a7c06d1d16bdb26fe3eb763f918e795efa3856df8409a21bcdf1d51089000',
     x86_64: 'f81b186e5091475ed9b0d21a1437397432b2909a4e06b87734ac04315e77d9e1'
  })

  depends_on 'cairo' => :library
  depends_on 'dbus' => :build
  depends_on 'eudev' => :library
  depends_on 'fontconfig' => :library
  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'glslang' => :build
  depends_on 'graphite' => :build
  depends_on 'gstreamer' => :library
  depends_on 'harfbuzz' # R
  depends_on 'hwdata' => :build
  depends_on 'libdrm' => :library
  depends_on 'libevdev' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libinput' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libunwind'
  depends_on 'libva' # R
  depends_on 'libwacom' => :build
  depends_on 'libwebp' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxcursor' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'libxxf86vm'
  depends_on 'linux_pam' => :library
  depends_on 'lua' => :library
  depends_on 'mesa' => :library
  depends_on 'pango' => :library
  depends_on 'pipewire' => :library
  depends_on 'pixman' => :library
  depends_on 'seatd' => :library
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :library
  depends_on 'wayland' => :library
  depends_on 'wayland_protocols'
  depends_on 'xcb_util_cursor' => :build
  depends_on 'xdg_base' => :build

  conflicts_ok # v4l_utils also provides edid-decode

  meson_options "-Dbackend-default=wayland \
        -Dbackend-drm=true \
        -Dbackend-rdp=false \
        -Dbackend-vnc=false \
        -Dcolor-management-lcms=false \
        -Dshell-ivi=false \
        -Dsystemd=false \
        -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland"

  meson_install_extras do
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
