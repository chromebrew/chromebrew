# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'package'

class Upx < Package
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.0.0-0108'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag '0108c1c34ef7fbcea99f6071dbd691670e43635f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-0108_armv7l/upx-4.0.0-0108-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-0108_armv7l/upx-4.0.0-0108-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-0108_i686/upx-4.0.0-0108-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.0.0-0108_x86_64/upx-4.0.0-0108-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'e10c5ea814b6983525a0ac4b6c108999157dcd5d50b7fafd22c924fab451696d',
     armv7l: 'e10c5ea814b6983525a0ac4b6c108999157dcd5d50b7fafd22c924fab451696d',
       i686: 'b40da75e3bc758432029f18625ed3439997f8e5f81d536996c326eee58c6dc20',
     x86_64: '05d13bf22d83b16e8037d1f744b601bada2821e09990bd6f00b5e99248f3e19a'
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
