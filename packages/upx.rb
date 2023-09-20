# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.1.0'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.1.0_armv7l/upx-4.1.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.1.0_armv7l/upx-4.1.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.1.0_i686/upx-4.1.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/upx/4.1.0_x86_64/upx-4.1.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b6e39f673a256b51ce6f8e0b80951b95ada8005ff14e21b11a1d2551ee01c333',
     armv7l: 'b6e39f673a256b51ce6f8e0b80951b95ada8005ff14e21b11a1d2551ee01c333',
       i686: 'fbf4fe2cdc597539968a81c318f2c3bdd02da1563517b646733adc4e4aef5279',
     x86_64: '11c22778db40cff248a3fec59193ecc710b8502f0ba7ea0d548a837f0380999c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
