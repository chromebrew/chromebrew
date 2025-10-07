require 'buildsystems/autotools'

class Oniguruma < Autotools
  description 'Oniguruma is a modern and flexible regular expressions library.'
  homepage 'https://github.com/kkos/oniguruma'
  version '6.9.10-1'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/kkos/oniguruma.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8852687c97e14224dcb9109d4a9a23e19cc6cd57c5a82c00e1b2765d8d81b4d5',
     armv7l: '8852687c97e14224dcb9109d4a9a23e19cc6cd57c5a82c00e1b2765d8d81b4d5',
       i686: '56cf9e186fb10f092884545430370de1bd355facd601723502a1b97a29b3d003',
     x86_64: '59f7cf8d137cb10eb3dff51744cea72ee5575ea05c58f4c9d65fa073781ad95d'
  })

  depends_on 'glibc' # R
end
