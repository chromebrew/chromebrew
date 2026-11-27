# Adapted from Arch Linux upx PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/upx/trunk/PKGBUILD

require 'buildsystems/cmake'

class Upx < CMake
  description 'Extendable, high-performance executable packer for several executable formats'
  homepage 'https://github.com/upx/upx'
  version '5.3.1'
  license 'custom GPL2'
  compatibility 'all'
  source_url 'https://github.com/upx/upx.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ac1e27216df3f1110a58521d98622625dede0d10b364fe573d695ff4e8c918b8',
     armv7l: 'ac1e27216df3f1110a58521d98622625dede0d10b364fe573d695ff4e8c918b8',
       i686: '052e5f7dbac3b15d4e27358048c7206a5f52b97dcbc6e790f6152711d567cd14',
     x86_64: 'f19c46f9d8088f972406a0f5b592db3f29eedda8d65e34d9ed2f33712d9c294e'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  cmake_options '-DUPX_CONFIG_DISABLE_GITREV=true'
end
