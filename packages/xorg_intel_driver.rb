# following https://github.com/archlinux/svntogit-packages/blob/packages/xf86-video-intel/trunk/PKGBUILD

require 'package'

class Xorg_intel_driver < Package
  description 'The Xorg Intel Driver package contains the X.Org Video Driver for Intel integrated video chips including 8xx, 9xx, Gxx, Qxx, HD, Iris, and Iris Pro graphics processors.'
  homepage 'https://01.org/linuxgraphics/'
  @_ver = '31486f40f8e8f8923ca0799aea84b58799754564'
  version "2.99.917+916+g#{@_ver[0..6]}"
  license 'MIT and ISC'
  compatibility 'x86_64'
  source_url "https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/-/archive/#{@_ver}/xf86-video-intel-#{@_ver}.tar.gz"
  source_sha256 '7936e8ddc2f09f272584cc9e9a2d265e9ab435f645ccd12085cd56291fa70653'
  binary_compression 'tar.zst'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_intel_driver/2.99.917+916+g31486f4_x86_64/xorg_intel_driver-2.99.917+916+g31486f4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '54715305c2ddab79a838edbccf707c2e9153912b7b8f07f6cf5d0fc0123f8cdb'
  })

  depends_on 'xorg_server'
  # No longer builds against current versions of libxvmc
  # See https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/-/issues/180#note_387356
  # depends_on 'libxvmc' => :build

  def self.build
    # LTO is broken with this build.
    # See https://gitlab.freedesktop.org/xorg/driver/xf86-video-intel/-/issues/28
    system "meson setup #{CREW_MESON_FNO_LTO_OPTIONS} \
            -Ddefault-dri=3 \
            -Dxvmc=false \
            builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
