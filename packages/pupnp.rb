require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.2.1'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f719adddc3a9b44050c9dc09c232841e3d7661a7ecb8dd8c6c585f2b31db506',
     armv7l: '8f719adddc3a9b44050c9dc09c232841e3d7661a7ecb8dd8c6c585f2b31db506',
       i686: '835a6ef1e3533980bc9bddc39626a1e11cad4b291d348720845a11c618fa3417',
     x86_64: 'b2944ad2e09d3d737b39192088dc0534ba0a6a8ee3530a564d50f5868c8eb59f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtest' => :build

  cmake_options "-DUPNP_ENABLE_TESTING=OFF -DGTest_DIR=#{CREW_LIB_PREFIX}/cmake/GTest"

  # Building tests fails.
  # Test failures on armv7l:
  # 50 - test-upnp-threadpool-overflow (Failed)
  # 51 - test-upnp-threadpool-overflow-static (Failed)
  # run_tests unless ARCH == 'armv7l'
end
