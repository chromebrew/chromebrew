# Adapted from Arch Linux faac PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/faac/trunk/PKGBUILD

require 'buildsystems/meson'

class Faac < Meson
  description 'Freeware Advanced Audio Coder'
  homepage 'https://www.audiocoding.com/'
  version '2.0'
  license 'GPL2 custom'
  compatibility 'all'
  source_url 'https://github.com/knik0/faac.git'
  git_hashtag "faac-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '453bbe8992d73081318a92180752682669e34cdb89f6d826c1d6a504a1b4e5c1',
     armv7l: '453bbe8992d73081318a92180752682669e34cdb89f6d826c1d6a504a1b4e5c1',
       i686: '5f5e04587bdab9ac49264e6ab6ace40277161e709ed15f06948cc509ce955f3f',
     x86_64: 'afa65ed29bd5c6bbda8813430ae4630c09a0ff14c71c3a1a4aea521ed3b30ea1'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
