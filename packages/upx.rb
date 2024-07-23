# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.2.3'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b726185f67f13c82f15467e2c5ce5275fa8f9472b99061a4beee840c5e09af80',
     armv7l: 'b726185f67f13c82f15467e2c5ce5275fa8f9472b99061a4beee840c5e09af80',
       i686: '0514f4f8a27c494f28dfabb956ad18deb2cde2a406991999d326ad4c8b579f7f',
     x86_64: '308e574c0e167177a04693ad203f6ce17b3842784071a331aa966d8794182946'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
