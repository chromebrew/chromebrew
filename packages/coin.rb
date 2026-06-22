require 'buildsystems/cmake'

class Coin < CMake
  description 'OpenGL-based, 3D graphics library'
  homepage 'https://github.com/coin3d/coin'
  version '4.0.10'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/coin3d/coin.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '203f1036045bfb490b437c7bc81fb7cc6055c4ecd51f736587740f6cfea20a6e',
     armv7l: '203f1036045bfb490b437c7bc81fb7cc6055c4ecd51f736587740f6cfea20a6e',
     x86_64: 'cd81aed1f1c16150b00d006d1aa2e0655f27a8b083e1fa8f8ded829ee941f06f'
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
