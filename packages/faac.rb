# Adapted from Arch Linux faac PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/faac/trunk/PKGBUILD

require 'buildsystems/meson'

class Faac < Meson
  description 'Freeware Advanced Audio Coder'
  homepage 'https://www.audiocoding.com/'
  version '2.1'
  license 'GPL2 custom'
  compatibility 'all'
  source_url 'https://github.com/knik0/faac.git'
  git_hashtag "faac-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61a87a50d1de4a0aaaae75b58b2315ed13fd03da1b8feabc241567e32bc42540',
     armv7l: '61a87a50d1de4a0aaaae75b58b2315ed13fd03da1b8feabc241567e32bc42540',
       i686: 'ae1f1f1efac6fd857d4f20a9e52e718801e24004a138b83f4c0bd6d0dca7f9ab',
     x86_64: '22bed9da5bf19ca53bf91c6a8888820e3e653289f68ea34e2446bcbe06d85e81'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
