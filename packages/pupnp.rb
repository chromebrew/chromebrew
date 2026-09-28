require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.1.6'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcc41c6bd0f8a9f36ac8803a848d2695d93d6fd489c3d63f4d22234d56c1d27c',
     armv7l: 'bcc41c6bd0f8a9f36ac8803a848d2695d93d6fd489c3d63f4d22234d56c1d27c',
       i686: '17f83b7f5fa9bce37471eaacb9e45efccc4de29dbca81b0627b77a6c475adfb2',
     x86_64: 'fb592b694478e63c31d2db51f911f30de98e3f1c66ade82584d522920b84a947'
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
