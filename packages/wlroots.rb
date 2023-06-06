# Adapted from Arch Linux wlroots PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/wlroots/trunk/PKGBUILD

require 'package'

class Wlroots < Package
  description 'Modular Wayland compositor library'
  homepage 'https://gitlab.freedesktop.org/wlroots/wlroots'
  version '0.16.1'
  license 'MIT'
  compatibility 'aarch64, armv7l, x86_64'
  source_url 'https://gitlab.freedesktop.org/wlroots/wlroots.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wlroots/0.16.1_armv7l/wlroots-0.16.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wlroots/0.16.1_armv7l/wlroots-0.16.1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/wlroots/0.16.1_x86_64/wlroots-0.16.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0722ae885c1a247b03319bfb9092d9bd429209fe7b4cec3ff26276904d7b7e34',
     armv7l: '0722ae885c1a247b03319bfb9092d9bd429209fe7b4cec3ff26276904d7b7e34',
     x86_64: 'e06e99287393b51a5cfde4adf5fc81eaf22cb67d7aae762cd864d907c22c6209'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'hwdata' => :build
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libxcb' # R
  depends_on 'libxkbcommon' # R
  depends_on 'mesa' # R
  depends_on 'pixman' # R
  depends_on 'seatd' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xwayland' # L

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Dxwayland=enabled \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
