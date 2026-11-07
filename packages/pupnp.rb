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
    aarch64: '140bdb32b577cc73b6f22a125e1ebd402e24eaec06c7134ebb0c026951653661',
     armv7l: '140bdb32b577cc73b6f22a125e1ebd402e24eaec06c7134ebb0c026951653661',
       i686: 'bead9ad0322e8da475c9a5707348f263262a137501771f8f3d7f7151f246d698',
     x86_64: '59b71433363dc5d7bfb103565a8825198ff1174c69c28bd1f6bc4292fba54f14'
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
