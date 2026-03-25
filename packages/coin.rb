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
    aarch64: '02db1dfa522732a1b351d42b061225465f4bc4a052e8af781834dbfe92ffd2e9',
     armv7l: '02db1dfa522732a1b351d42b061225465f4bc4a052e8af781834dbfe92ffd2e9',
     x86_64: 'b9ddb60f1d10b0715b292cdee5d197a658ecf7290fa5fcb83c4932e9be1c5b84'
  })

  depends_on 'boost' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libglvnd' => :library
  depends_on 'libx11' => :library

  run_tests
end
