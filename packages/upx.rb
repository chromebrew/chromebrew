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
    aarch64: 'd33d8bf41db6e536dc9302b62bbeb47233ab6428f5c759d4c055612aaf7551b1',
     armv7l: 'd33d8bf41db6e536dc9302b62bbeb47233ab6428f5c759d4c055612aaf7551b1',
       i686: 'b2be0ce308cd928c01afc387384f151ecc9835e7cbd8e513baa73b0d0cad0758',
     x86_64: '015f51b52d826208baaa029f58a0c98de722311989df83a7f322f8e4da3242cf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
