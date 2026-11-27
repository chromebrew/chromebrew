require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.2.5'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f85c12514df435e310ead04d9e1fe503560e373993b06bd20581afc17fb790e4',
     armv7l: 'f85c12514df435e310ead04d9e1fe503560e373993b06bd20581afc17fb790e4',
       i686: '7e5d3288c3849a1c6881c2b9e4bf8603a9611d31da3788d005bb149e11cf394b',
     x86_64: 'c68456b2a6e791038d4db3ef01262c29cb9d7ccd7b9a8ee25bdddb482dbd1217'
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
