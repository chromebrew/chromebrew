# Adapted from Arch Linux xorg-xset PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xset/trunk/PKGBUILD

require 'package'

class Xorg_xset < Package
  description 'User preference utility for X'
  homepage 'https://xorg.freedesktop.org/'
  version '1.2.4'
  license 'X11'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/app/xset-1.2.4.tar.bz2'
  source_sha256 'e4fd95280df52a88e9b0abc1fee11dcf0f34fc24041b9f45a247e52df941c957'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xset/1.2.4_armv7l/xorg_xset-1.2.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xset/1.2.4_armv7l/xorg_xset-1.2.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xset/1.2.4_i686/xorg_xset-1.2.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xorg_xset/1.2.4_x86_64/xorg_xset-1.2.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '37a3b25eb1538f0e595fc48a59c3086246dbc790f17cb8ef682fa3aa665f99e2',
     armv7l: '37a3b25eb1538f0e595fc48a59c3086246dbc790f17cb8ef682fa3aa665f99e2',
       i686: '5b3ce6762be335c7ef84b3d4b27b4145243f83a7f3b96d0173eabdff7e9ad4e6',
     x86_64: '5fa43e8744dbc19dbeff5378f06fef3eac4e27e4729d63c586c33d594711284f'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxmu' # R
  depends_on 'util_macros' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
    --without-fontcache \
    --without-xf86misc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
