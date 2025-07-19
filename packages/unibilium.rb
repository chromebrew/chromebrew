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
    aarch64: '7f068000fbd0b9d2b85c3aece98dfed0af7d023ab9b32cb7e2d9c67ef0c9afce',
     armv7l: '7f068000fbd0b9d2b85c3aece98dfed0af7d023ab9b32cb7e2d9c67ef0c9afce',
       i686: '176f96d97ef20021f20cddcef7a8700233b4e2ac4a9f76305ee71d104a96d154',
     x86_64: '624efa8c596f133e37ba948023c99ac55204aac5edc019cfbf197d27e4e6f8be'
  })

  depends_on 'glibc'
end
