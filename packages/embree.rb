require 'buildsystems/cmake'

class Embree < CMake
  description 'Intel Embree is a high-performance ray tracing library.'
  homepage 'https://www.embree.org/'
  version '4.3.1'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/RenderKit/embree.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: 'fa8f7c350310b0add25b03f7d762ed3817ecf068f10b63c4a319759ea6ab19c4'
  })

  depends_on 'glfw'
  depends_on 'libjpeg_turbo'
  depends_on 'openimageio'
  depends_on 'tbb'

  # Embree is not FHS compliant with EMBREE_ZIP_MODE enabled, installing two shell scripts at the root of CREW_PREFIX.
  cmake_options '-DEMBREE_TUTORIALS=OFF -DEMBREE_TESTING_INSTALL_TESTS=OFF -DEMBREE_ZIP_MODE=OFF'
end
