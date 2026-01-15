# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.1.0'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '884a08ad7bb356a1cc72e797a0d87dea86813496fb769c9adcb27685559daad7',
     armv7l: '884a08ad7bb356a1cc72e797a0d87dea86813496fb769c9adcb27685559daad7',
       i686: '287e1d84b591cdb0c1b6420cb3fcbdd6ff6f850f783a122bda4cf82c7dcaf4d9',
     x86_64: 'ae4289bdcc3b7c790feb54c3e316a74f47638c51ef57ffeab7f0287d75a88838'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
