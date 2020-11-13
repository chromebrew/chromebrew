# Adapted from Arch Linux xorg-xdpyinfo PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/xorg-xdpyinfo/trunk/PKGBUILD

require 'package'

class Xdpyinfo < Package
  description 'Display information utility for X'
  homepage 'https://gitlab.freedesktop.org/xorg/app/xdpyinfo'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/archive/individual/app/xdpyinfo-1.3.2.tar.bz2'
  source_sha256 '30238ed915619e06ceb41721e5f747d67320555cc38d459e954839c189ccaf51'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xdpyinfo-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xdpyinfo-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xdpyinfo-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xdpyinfo-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f5d670f0eb6a4f9d0d47ca597f401e9596cee02c110d824462e599f9f4a1ca8',
     armv7l: '7f5d670f0eb6a4f9d0d47ca597f401e9596cee02c110d824462e599f9f4a1ca8',
       i686: '052a899e25cb340d886152f983896b1f28404d74253149fd1bf7323a39d5de68',
     x86_64: '3876556bb0c33537aabfb08c1929b06b1a88e90df56f87f838b3e4e47491aae9',
  })

  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxtst'
  depends_on 'libxxf86vm'
  depends_on 'libxrender'
  depends_on 'libxcomposite'
  depends_on 'libxinerama'
  depends_on 'xorg_proto'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
