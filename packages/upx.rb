# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.2.0'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2457dbf8f4f229fb1d0db442952957413ac4bef8cba73cd2259e8c8db28b37a',
     armv7l: 'e2457dbf8f4f229fb1d0db442952957413ac4bef8cba73cd2259e8c8db28b37a',
       i686: '0381c245cc75b21ad68796f1c440d3b31200097bcd4e347faa05a016f673de25',
     x86_64: '6670e7a8b76e69e82a48c2e6462b80036c9d6175decda2647deadecf23429316'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
