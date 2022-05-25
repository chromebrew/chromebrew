# Adapted from Arch Linux ethtool PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/ethtool/trunk/PKGBUILD

require 'package'

class Ethtool < Package
  description 'Utility for controlling network drivers and hardware'
  homepage 'https://www.kernel.org/pub/software/network/ethtool/'
  version '5.14'
  license 'LGPL2.1'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/software/network/ethtool/ethtool-5.14.tar.xz'
  source_sha256 'bb13db91915cacd7a492b65b65df07a67e4b974ddbeaf76205b1945a23d27686'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_armv7l/ethtool-5.14-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_armv7l/ethtool-5.14-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_i686/ethtool-5.14-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_x86_64/ethtool-5.14-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ded7bc75870dca4c022bb97fc99a2da72f54833d3ab077f44bce5ea551de72dc',
     armv7l: 'ded7bc75870dca4c022bb97fc99a2da72f54833d3ab077f44bce5ea551de72dc',
       i686: 'ab5f60fc5634cd451ff7d28ee791c48ea74e8be0fbc082cb4e032ebd98572c84',
     x86_64: 'b32262fb8c150d67098b274a7181288caf07dcbcac508307125ba4bff8926b81'
  })

  depends_on 'libmnl'

  def self.build
    system "#{CREW_ENV_OPTIONS} \
             ./configure #{CREW_OPTIONS} \
             --mandir=#{CREW_MAN_PREFIX} \
             --sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end

  def self.check
    system 'make check'
  end
end
