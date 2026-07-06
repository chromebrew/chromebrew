# Adapted from Arch Linux unibilium PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/unibilium/trunk/PKGBUILD

require 'buildsystems/autotools'

class Unibilium < Autotools
  description 'A terminfo parsing library'
  homepage 'https://github.com/neovim/unibilium'
  version '2.1.2'
  license 'LGPL3'
  compatibility 'all'
  source_url 'https://github.com/neovim/unibilium.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dafb10dbb938f0d425223012e18e6915777e3499728bda0709f6175035748976',
     armv7l: 'dafb10dbb938f0d425223012e18e6915777e3499728bda0709f6175035748976',
       i686: '9d1d5e1c6da59cfcdf90779719fd4f89ef9b72b5dacb1154556cd7c95d24e595',
     x86_64: 'cdeb18bbebae3899dc49df4b84bef4de8e52b78be1eb2b6a1023a3052baea2fb'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
