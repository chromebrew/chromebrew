# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.0.0'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5bdebb37916fc9b21ea0d075d8467d9b9e415ed84ef5e52214f1da93d407c459',
     armv7l: '5bdebb37916fc9b21ea0d075d8467d9b9e415ed84ef5e52214f1da93d407c459',
       i686: 'b2be0ce308cd928c01afc387384f151ecc9835e7cbd8e513baa73b0d0cad0758',
     x86_64: '015f51b52d826208baaa029f58a0c98de722311989df83a7f322f8e4da3242cf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
