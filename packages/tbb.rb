require 'buildsystems/cmake'

class Tbb < CMake
  description 'High level abstract threading library'
  homepage 'https://github.com/oneapi-src/oneTBB'
  version '2023.2.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oneapi-src/oneTBB.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '34295f614ecf493000f77784c4048044545f8defcc0d4f4e764b911b0aff54e5',
     armv7l: '34295f614ecf493000f77784c4048044545f8defcc0d4f4e764b911b0aff54e5',
       i686: 'e2e0bf67813ad9318edd718fbb65d0ff234b66e2dee1cf81ae85bc6d86b1e1bc',
     x86_64: '1e8a2b327250dc3c41c1110ee5124a7eb1f96f0725846142491f874227307ceb'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'hwloc' => :library
  depends_on 'swig' => :build

  cmake_options '-DTBB4PY_BUILD=ON -DTBB_TEST=OFF'
end
