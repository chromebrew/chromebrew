# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.0.2'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad4f738c6104ce9d8a27084d685cf939386bf8ac99d535b791ed854cee4f2374',
     armv7l: 'ad4f738c6104ce9d8a27084d685cf939386bf8ac99d535b791ed854cee4f2374',
       i686: '03086ab75248a6ed88d2977de594e5c231e221fcdf1b1baa76353d5a72cd31df',
     x86_64: 'df1d1fb2b7ef5caca160a57512bce98b3e1e68c7dcda70e7320884b87ffcd034'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
