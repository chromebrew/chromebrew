# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.1.1'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8ff8a3bf41221f1566ffa57e8acbfef954ffce2d0b88afc5278d945abfe80c2',
     armv7l: 'a8ff8a3bf41221f1566ffa57e8acbfef954ffce2d0b88afc5278d945abfe80c2',
       i686: 'f0d5cd78fd2db5fb45278876b15a534b8b16e13b087fe00fc04976e31f0e2313',
     x86_64: '622ca6ad5869a74d263d986a0b3c1f1ea2ffe29f6e0612769f9758a5172d7c8d'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
