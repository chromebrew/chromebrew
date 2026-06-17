require 'buildsystems/cmake'

class Coin < CMake
  description 'OpenGL-based, 3D graphics library'
  homepage 'https://github.com/coin3d/coin'
  version '4.0.9'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/coin3d/coin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd5ebe855a22351ae080787b0168fb9d11e489afc0cd57063bea09b3160d32f40',
     armv7l: 'd5ebe855a22351ae080787b0168fb9d11e489afc0cd57063bea09b3160d32f40',
     x86_64: '54c40cab61e7b4fe48ea3649bfbc9738e5584f384e387f3dcb8a28630446ad34'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libice' => :library
  depends_on 'libsm' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library

  run_tests
end
