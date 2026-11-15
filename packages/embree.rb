require 'buildsystems/cmake'

class Embree < CMake
  description 'Intel Embree is a high-performance ray tracing library.'
  homepage 'https://www.embree.org/'
  version '4.4.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/RenderKit/embree.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '7f397dc49a97b81f0d4716276e91e3fec4306a924c9c0d7bfcfe5d6689aef9f0'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glfw' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'openimageio' => :library
  depends_on 'tbb' => :library

  # Embree is not FHS compliant with EMBREE_ZIP_MODE enabled, installing two shell scripts at the root of CREW_PREFIX.
  cmake_options '-DEMBREE_TUTORIALS=OFF -DEMBREE_TESTING_INSTALL_TESTS=OFF -DEMBREE_ZIP_MODE=OFF'
end
