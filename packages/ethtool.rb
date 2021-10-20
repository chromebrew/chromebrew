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

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_armv7l/ethtool-5.14-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_armv7l/ethtool-5.14-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ethtool/5.14_x86_64/ethtool-5.14-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'cd96fbac9f4b9a76be99479b780795dbd6b8e2dffca87ecf7a7238710a7a8af2',
     armv7l: 'cd96fbac9f4b9a76be99479b780795dbd6b8e2dffca87ecf7a7238710a7a8af2',
     x86_64: 'db9958acc1f93a202b25c543ba811a12bea5cc7ea3a634a828aee7e2d9b5294a'
  })

  depends_on 'libmnl'

  def self.build
    system "#{CREW_ENV_OPTIONS} \
             ./configure #{CREW_OPTIONS} \
             --mandir=#{CREW_PREFIX}/share/man \
             --sbindir=#{CREW_PREFIX}/bin"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
