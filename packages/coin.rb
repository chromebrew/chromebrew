require 'buildsystems/cmake'

class Coin < CMake
  description 'OpenGL-based, 3D graphics library'
  homepage 'https://github.com/coin3d/coin'
  version '4.0.8'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/coin3d/coin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47e2d1b797491b5792635c28ea95dedd6ba517bd7be015bdb9eed0ce95a1116c',
     armv7l: '47e2d1b797491b5792635c28ea95dedd6ba517bd7be015bdb9eed0ce95a1116c',
     x86_64: '03fb9edad151f6b418e39e98eb67a5945a28562892379ec46a10177d5c4c0e10'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libx11' => :library

  run_tests
end
