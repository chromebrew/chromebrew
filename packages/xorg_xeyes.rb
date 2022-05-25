# Adapted from Arch Linux xorg-xeyes PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xeyes/trunk/PKGBUILD

require 'package'

class Xorg_xeyes < Package
  description 'Follow the mouse/SHAPE extension X demo'
  homepage 'https://xorg.freedesktop.org/'
  version '1.2.0'
  license 'X11'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/app/xeyes-1.2.0.tar.bz2'
  source_sha256 'f8a17e23146bef1ab345a1e303c6749e42aaa7bcf4f25428afad41770721b6db'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xeyes/1.2.0_armv7l/xorg_xeyes-1.2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xeyes/1.2.0_armv7l/xorg_xeyes-1.2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xeyes/1.2.0_i686/xorg_xeyes-1.2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xeyes/1.2.0_x86_64/xorg_xeyes-1.2.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e4e33bea55f33b1267d36f289b596c2c0bdb6562b26efaf14fcf5791469941e7',
     armv7l: 'e4e33bea55f33b1267d36f289b596c2c0bdb6562b26efaf14fcf5791469941e7',
       i686: '6c173c828328c95be613e58a0a1d242083f723a15a79cf73657966a5d11c121c',
     x86_64: 'd900a6ae3a92f0d5e157138ba3c6bbf8337d8e53132f6a2e4475f4cdd20b8bf8'
  })

  depends_on 'libx11'
  depends_on 'libxt'
  depends_on 'libxext'
  depends_on 'libxmu'
  depends_on 'libxrender'
  depends_on 'libxi'
  depends_on 'util_macros' => :build
  depends_on 'libxfixes' => :build
  depends_on 'glibc' # R
  depends_on 'libxcb' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
