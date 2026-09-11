require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.1.0'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26566a60c2be3f784250158f9d9076b6e3c879d235ec515d3a86b12744351b4b',
     armv7l: '26566a60c2be3f784250158f9d9076b6e3c879d235ec515d3a86b12744351b4b',
       i686: 'e6354f250114a77ace8d6837f8d0dbfe8628c3c8c1be8c31b037a6d90c535559',
     x86_64: 'eb581399cf88c52954aec915fd779102f1a6a67f933f47794e8439b2844b2de1'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtest' => :build

  cmake_options "-DGTest_DIR=#{CREW_LIB_PREFIX}/cmake/GTest"
  # Test failures on armv7l:
  # 50 - test-upnp-threadpool-overflow (Failed)
  # 51 - test-upnp-threadpool-overflow-static (Failed)
  run_tests unless ARCH == 'armv7l'
end
