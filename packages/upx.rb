# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'package'

class Upx < Package
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.0.0-8a82'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag '8a828474ca68fbbf2c2939722c3611bdb7f9c597'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-8a82_armv7l/upx-4.0.0-8a82-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-8a82_armv7l/upx-4.0.0-8a82-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-8a82_i686/upx-4.0.0-8a82-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-8a82_x86_64/upx-4.0.0-8a82-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9d6e12cf7ff3e8ee1c1819bdbb455c34d2f8fc503f1d4ea250419f026714b725',
     armv7l: '9d6e12cf7ff3e8ee1c1819bdbb455c34d2f8fc503f1d4ea250419f026714b725',
       i686: '41c11c923da18814495480a66e7aa5fb052dcb5e2932b05b179223d96c811d3d',
     x86_64: '633999fc136f6daae381fac71922c9f19cf4e93efb928b266afc4ebdb59cbf21'
  })

  depends_on 'ucl'

  def self.patch
    # Disable a warning. upx believes this is not a release version if the git revision is set.
    system "sed -i 's/bool warn = true/bool warn = false/' src/main.cpp"
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} make  \
      CHECK_WHITESPACE=/bin/true \
      UPX_LZMA_VERSION=0x465 \
      UPX_LZMADIR=`pwd` \
      all"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'src/upx.out', "#{CREW_DEST_PREFIX}/bin/upx", mode: 0o755
    FileUtils.install 'doc/upx.1', "#{CREW_DEST_MAN_PREFIX}/man1/upx.1", mode: 0o644
  end
end
