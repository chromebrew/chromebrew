# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '4.2.2'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63b9e8eef59a8fb261f4109b771611492542c14af65600a9899bbab7a6439130',
     armv7l: '63b9e8eef59a8fb261f4109b771611492542c14af65600a9899bbab7a6439130',
       i686: '78e7e840b8a3ad87b337e500e95dbd3ba7f7958db3af7ca364ec31fcbdc8e47b',
     x86_64: 'fa3a899c75a7c2f1c563ece13af63e941fcbd16745b041e9b50b28c9f1363e40'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
