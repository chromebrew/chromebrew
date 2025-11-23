require 'buildsystems/cmake'

class Tbb < CMake
  description 'High level abstract threading library'
  homepage 'https://github.com/oneapi-src/oneTBB'
  version '2022.3.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/oneapi-src/oneTBB.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a2453136b00c543298f959a58393e981f12f0bf26857a1244b8e74a0325b438',
     armv7l: '9a2453136b00c543298f959a58393e981f12f0bf26857a1244b8e74a0325b438',
       i686: '7334111f25246a231f2529bdfef298fd405eac6f90847e626ae11116816ade3e',
     x86_64: 'afcd9c317b60065c885d90c2ec2558a5314dad85ca1574e3934d7aba3bff6cd0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'hwloc'
  depends_on 'swig' => :build

  cmake_options '-DTBB4PY_BUILD=ON -DTBB_TEST=OFF'
end
