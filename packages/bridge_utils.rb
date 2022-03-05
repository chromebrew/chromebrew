# Adapted from Arch Linux bridge-utils PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/bridge-utils/trunk/PKGBUILD

require 'package'

class Bridge_utils < Package
  description 'Utilities for configuring the Linux ethernet bridge'
  homepage 'https://wiki.linuxfoundation.org/networking/bridge'
  version '1.7.1'
  license 'GPL'
  compatibility 'all'
  source_url 'https://mirrors.edge.kernel.org/pub/linux/utils/net/bridge-utils/bridge-utils-1.7.1.tar.xz'
  source_sha256 'a61d8be4f1a1405c60c8ef38d544f0c18c05b33b9b07e5b4b31033536165e60e'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bridge_utils/1.7.1_armv7l/bridge_utils-1.7.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bridge_utils/1.7.1_armv7l/bridge_utils-1.7.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bridge_utils/1.7.1_i686/bridge_utils-1.7.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/bridge_utils/1.7.1_x86_64/bridge_utils-1.7.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '41f566515eee8a83ce368c61e912cb11fcb023da3dca2573ab45ca99c85a3b58',
     armv7l: '41f566515eee8a83ce368c61e912cb11fcb023da3dca2573ab45ca99c85a3b58',
       i686: '3a0367f328261023cd4c9b5d3e464822197b2fdce828e170ca654fb2e497cbe7',
     x86_64: 'bf7b7e4461e09843909ce3585e4b11a3187f38b09471170f35fdc75e4dc72929'
  })

  def self.build
    system 'autoreconf -fvi'
    system "./configure \
      #{CREW_OPTIONS} \
      --sbindir=#{CREW_PREFIX}/bin \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
