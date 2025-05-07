# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.0.1'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f50e1e632152b514b6a0cb392a5de09999a0e48ca5e0992eae2a1d166f7d441',
     armv7l: '5f50e1e632152b514b6a0cb392a5de09999a0e48ca5e0992eae2a1d166f7d441',
       i686: 'c22892b839bd81e66a186b7842c6467fdc8e19652807b21229c9be53bf924584',
     x86_64: 'b03c020457e1472ecf7aae12a8392de414aa01dd210178757cfc908013ff8184'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
