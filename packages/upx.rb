# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'package'

class Upx < Package
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.0.0-66fe'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag '66fe8a624d1a4945173955b9edd626664708b383'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-66fe_armv7l/upx-4.0.0-66fe-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-66fe_armv7l/upx-4.0.0-66fe-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-66fe_i686/upx-4.0.0-66fe-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-66fe_x86_64/upx-4.0.0-66fe-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '412f53e51a9e4cc07d1c5eb43a19afbfca359c045faa0cd821824c56e5e34e95',
     armv7l: '412f53e51a9e4cc07d1c5eb43a19afbfca359c045faa0cd821824c56e5e34e95',
       i686: 'c594ec89c0596866ae7d919465615923dd2d5244b926bb6d0b0f1aed10fbb4d6',
     x86_64: 'cc24e68b8f1ae2212fb375333a64a3bfb3220df3e07811c38687cd87789c1d49'
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
