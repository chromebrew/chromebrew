require 'buildsystems/meson'

class Weston < Meson
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'https://wayland.freedesktop.org'
  version '15.0.1'
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

  depends_on 'aml' => :library
  depends_on 'cairo' => :library
  depends_on 'dbus' => :build
  depends_on 'eudev' => :library
  depends_on 'fontconfig' => :library
  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glslang' => :build
  depends_on 'graphite' => :build
  depends_on 'gstreamer' => :library
  depends_on 'harfbuzz' # R
  depends_on 'hwdata' => :build
  depends_on 'libdrm' => :library
  depends_on 'libeeudev' => :library
  depends_on 'libevdev' # R
  depends_on 'libglvnd' => :library
  depends_on 'libinput' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libminigbm' => :library
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
  depends_on 'neatvnc' => :library
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
        -Dcolor-management-lcms=false \
        -Dremoting=true \
        -Dshell-ivi=false \
        -Dsystemd=false \
        -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland"

  def self.patch
    # https://gitlab.freedesktop.org/wayland/weston/-/issues/1049
    # file = File.read 'subprojects/neatvnc.wrap'
    # file.gsub!('revision = v0.7.0', 'revision = v0.9.5')
    # File.write('subprojects/neatvnc.wrap', file)
    #
    # Install Top of Tree neatvnc and aml as deps instead, and make
    # weston handle those versions.
    FileUtils.rm_rf 'subprojects/neatvnc'
    FileUtils.rm_rf 'subprojects/aml.wrap'
    FileUtils.rm_rf 'subprojects/neatvnc.wrap'
    File.write 'weston_vnc.patch', <<~'VNCPATCHEOF'
      --- a/libweston/backend-vnc/meson.build	2025-09-24 09:44:35.000000000 -0400
      +++ b/libweston/backend-vnc/meson.build	2025-09-24 10:36:09.653992251 -0400
      @@ -3,12 +3,12 @@ if not get_option('backend-vnc')
       endif

       config_h.set('BUILD_VNC_COMPOSITOR', '1')
      -dep_neatvnc = dependency('neatvnc', version: ['>= 0.7.0', '< 0.10.0'], required: false, fallback: ['neatvnc', 'neatvnc_dep'])
      +dep_neatvnc = dependency('neatvnc', version: ['>= 0.7.0', '< 0.11.0'], required: false, fallback: ['neatvnc', 'neatvnc_dep'])
       if not dep_neatvnc.found()
       	error('VNC backend requires neatvnc which was not found. Or, you can use \'-Dbackend-vnc=false\'.')
       endif

      -dep_aml = dependency('aml', version: ['>= 0.3.0', '< 0.4.0'], required: false, fallback: ['aml', 'aml_dep'])
      +dep_aml = dependency('aml1', version: ['>= 0.3.0', '< 1.1.0'], required: false, fallback: ['aml', 'aml_dep'])
       if not dep_aml.found()
       	error('VNC backend requires libaml which was not found. Or, you can use \'-Dbackend-vnc=false\'.')
       endif
    VNCPATCHEOF
    system 'patch -Np1 -i weston_vnc.patch'
  end

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
