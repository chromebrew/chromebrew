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
    aarch64: '4d05900090331e849191b1f484d6afd6e9207bfa61537b48520d0e9ad0b7972a',
     armv7l: '4d05900090331e849191b1f484d6afd6e9207bfa61537b48520d0e9ad0b7972a',
       i686: 'f30e0f54b58554c56abd0d97e6a78ed86337e5d971fa6a0818bcb4b006307867',
     x86_64: '5efa6a7f3b97436888e9530583abfa0e4362ee88bd436e7a73c0ee32c662d767'
  })

  cmake_options '-DALSOFT_EXAMPLES=OFF'
end
