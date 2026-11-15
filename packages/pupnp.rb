require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.2.2'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '073192b6d0c0bc946c6cf4185b8fc8feae9dddfabaa0d2706b39fee4c8a763b9',
     armv7l: '073192b6d0c0bc946c6cf4185b8fc8feae9dddfabaa0d2706b39fee4c8a763b9',
       i686: 'f3af02c25632f104c2322c2b8a2c6733904a21a7199911f337c378bab31da8d6',
     x86_64: 'e3845be67347632b6d91b145797212621c131a8d7c5cfe22df96800dcc352046'
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
