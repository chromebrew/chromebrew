require 'package'

class Weston < Package
  description 'Weston is the reference implementation of a Wayland compositor, and a useful compositor in its own right.'
  homepage 'http://wayland.freedesktop.org'
  @_ver = '12.0.0'
  version @_ver
  license 'MIT and CC-BY-SA-3.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/wayland/weston.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/12.0.0_armv7l/weston-12.0.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/12.0.0_armv7l/weston-12.0.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/weston/12.0.0_x86_64/weston-12.0.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '52bf23d0bd9eb64a05f172996dc921f049ba409ae8c6554d81b3b9cc3e5c8a88',
     armv7l: '52bf23d0bd9eb64a05f172996dc921f049ba409ae8c6554d81b3b9cc3e5c8a88',
     x86_64: '01e6bad830f2bdc6232872ffd71bcd1a1e6096df8347b15fc255a658e8c05f23'
  })

  depends_on 'dbus' => :build
  depends_on 'eudev' # R
  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
  depends_on 'llvm_lib16' => :build
  depends_on 'mesa' # R
  depends_on 'pango' # R
  depends_on 'pipewire' # R
  depends_on 'pixman' # R
  depends_on 'seatd' # R
  depends_on 'wayland_protocols'
  depends_on 'wayland' # R
  depends_on 'xcb_util_cursor' => :build
  depends_on 'xdg_base' => :build
  depends_on 'zlibpkg' # R

  def self.build
    system "LIBRARY_PATH=#{CREW_LIB_PREFIX} meson setup #{CREW_MESON_OPTIONS} \
        -Dbackend-default=wayland \
        -Dbackend-drm=true \
        -Dbackend-rdp=false \
        -Dcolor-management-lcms=false \
        -Dlauncher-libseat=true \
        -Dremoting=true \
        -Dshell-ivi=false \
        -Dsystemd=false \
        -Dxwayland-path=#{CREW_PREFIX}/bin/Xwayland \
        builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
    File.write 'weston.ini', <<~WESTON_INI_EOF
      [core]
      xwayland=true

      [terminal]
      font=Cousine
      EOF"
    WESTON_INI_EOF
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.install 'weston.ini', "#{CREW_DEST_HOME}/.config/weston.ini", mode: 0o644
  end

  def self.postinstall
    puts
    puts 'To run weston with xwayland try something like this:'.lightblue
    puts 'export WAYLAND_DISPLAY=wayland-1'.lightblue
    puts 'WAYLAND_DISPLAY=wayland-0 weston -Swayland-1 --xwayland'.lightblue
    puts
  end
end
