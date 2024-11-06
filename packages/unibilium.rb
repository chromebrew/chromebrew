# Adapted from Arch Linux unibilium PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/unibilium/trunk/PKGBUILD

require 'buildsystems/cmake'

class Unibilium < CMake
  description 'A terminfo parsing library'
  homepage 'https://github.com/neovim/unibilium'
  @_ver = '2.1.1'
  version "#{@_ver}-1"
  license 'LGPL3'
  compatibility 'all'
  source_url 'https://github.com/neovim/unibilium.git'
  git_hashtag "v#{@_ver}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3ba3681184d593175f8956644605a72cbc392ba84b95b23c6d49947241e1e292',
     armv7l: '3ba3681184d593175f8956644605a72cbc392ba84b95b23c6d49947241e1e292',
       i686: '19c2e89a17071e6e11d0945811db43cc621fd37c3e60e4fdb34d81f98fcd7ab1',
     x86_64: '54249968af3a494f655b4ba09f79b6442bd2942ee7806efd088652e7e317b14c'
  })

  depends_on 'glibc'
end
