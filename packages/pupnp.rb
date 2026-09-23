require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.1.2'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc0891108f1575a78a097640127e6cd33d4cf4918fafe41c482c647525fa49f9',
     armv7l: 'fc0891108f1575a78a097640127e6cd33d4cf4918fafe41c482c647525fa49f9',
       i686: '509a262a18c9433a7b32bdf848dc0555a103d35083efbcf479634aa226edebaa',
     x86_64: 'badcc4882f2ee1d53bc66858bdd7282eeb1def76602a1e62dd46a316f2365b3f'
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
