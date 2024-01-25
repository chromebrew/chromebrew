require 'buildsystems/cmake'

class Pocl < CMake
  description 'PoCL is a portable open source (MIT-licensed) implementation of the OpenCL standard.'
  homepage 'http://portablecl.org/'
  version '5.0'
  license 'MIT'
  compatibility 'x86_64 i686'
  source_url 'https://github.com/pocl/pocl.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '45cb227302d57f20b37170c6763907aa06e0a5a282b9b0ecc592a6895bd83012',
      i686: '0f92022885e2db69a23963196f668c2a698c5883e0d9d8b678891b6789046608'
  })

  depends_on 'cmake' => :build
  depends_on 'llvm' => :build
  depends_on 'hwloc'

  cmake_options '-DLLC_HOST_CPU=x86-64'
end
