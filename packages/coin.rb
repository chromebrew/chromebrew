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
    aarch64: 'd5ed0e034c6bdea85c1d6a8115191e953857be31d1b569ad25f858a0972cff96',
     armv7l: 'd5ed0e034c6bdea85c1d6a8115191e953857be31d1b569ad25f858a0972cff96',
     x86_64: '032949e20b09516ed2822181bf9722e6a7effcf2e771eddd819c1b528d371cb2'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libice' => :library
  depends_on 'libsm' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library

  run_tests
end
