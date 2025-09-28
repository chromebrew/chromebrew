require 'buildsystems/cmake'

class Openal < CMake
  description 'OpenAL Soft is a software implementation of the cross-platform OpenAL 3D audio API appropriate for use with gaming applications and many other types of audio applications.'
  homepage 'https://openal-soft.org/'
  version '1.24.3'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/kcat/openal-soft.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4fad76fa80a35e5ed2b551623610a764942c599caa606474bb9585da30dd648',
     armv7l: 'f4fad76fa80a35e5ed2b551623610a764942c599caa606474bb9585da30dd648',
       i686: '34754828e5fdf5632b1a72f5632568fd3484b1edca17d14692f7bfa5578a0752',
     x86_64: 'ad3c151c3cd255fac16bd21bf207ebcc14928d740691fc74ee5d5537627bb2d7'
  })

  cmake_options '-DALSOFT_EXAMPLES=OFF'
end
