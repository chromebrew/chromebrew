require 'buildsystems/cmake'

class Embree < CMake
  description 'Intel Embree is a high-performance ray tracing library.'
  homepage 'https://www.embree.org/'
  version '4.5.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/RenderKit/embree.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'a6e9259006570d0f1d2ca72aca0915aaef07c48569b64789c906fb2628df598d'
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
