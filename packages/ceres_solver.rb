require 'buildsystems/cmake'

class Ceres_solver < CMake
  description 'A large scale non-linear optimization library.'
  homepage 'http://ceres-solver.org/'
  version '2.2.0'
  license 'BSD-3 Clause'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ceres-solver/ceres-solver.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51b5bf4373ff846534039c881f972b4544561c717b8e6896f17a80c1e4f11f0f',
     armv7l: '51b5bf4373ff846534039c881f972b4544561c717b8e6896f17a80c1e4f11f0f',
     x86_64: 'b0c165a056e29016c8496988f2ea813ee7033763666c0ce136e8e752ed96303c'
  })

  depends_on 'eigen'
  depends_on 'glog'

  cmake_options '-DBUILD_SHARED_LIBS=ON -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF'
  run_tests
end
