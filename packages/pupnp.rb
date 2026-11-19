require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.2.4'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '739639989c93875703a46e179338540d6659f579bdddf4ea0977609b4e570c9a',
     armv7l: '739639989c93875703a46e179338540d6659f579bdddf4ea0977609b4e570c9a',
       i686: '6df22598bc7bc3247a9aa28b6023e134416901467f61e1cddef0b5870514a808',
     x86_64: '8fb3024bd906908fd5a585a1f134b0e09f5b61bda35f3ab2c4195aa224d85f8d'
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
