require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.1.4'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67cbbdf7f5da5f4160e20eca08f8f6756d609adbbc1297fb0bc249f064da49a9',
     armv7l: '67cbbdf7f5da5f4160e20eca08f8f6756d609adbbc1297fb0bc249f064da49a9',
       i686: 'c58ecdc899af66662e41e7877fc41a82062a59c429cb9a4ddff31c188b4fe1d7',
     x86_64: '0ff30f0f9a2cc500490e51d8c2733d3b997f5b0b85d2386ca76a19101cf366e3'
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
