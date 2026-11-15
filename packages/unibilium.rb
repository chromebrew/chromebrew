# Adapted from Arch Linux unibilium PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/unibilium/trunk/PKGBUILD

require 'buildsystems/autotools'

class Unibilium < Autotools
  description 'A terminfo parsing library'
  homepage 'https://github.com/neovim/unibilium'
  version '2.1.4'
  license 'LGPL3'
  compatibility 'all'
  source_url 'https://github.com/neovim/unibilium.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '449612c91e99431b1982ab8139da5fe1ceab918243b69201f4fb159e1586ddeb',
     armv7l: '449612c91e99431b1982ab8139da5fe1ceab918243b69201f4fb159e1586ddeb',
       i686: '74ededa129f12dfd56a063607dd25b8e60cb773498af334818ea8a1853edc6a4',
     x86_64: 'f40d6c2cd7e59bec236d7cd82507b140303841c19792c96a72241162680209c7'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
