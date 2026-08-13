require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.0.6'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5af18c18464343ac82bc4ab201a81fd91c25ec6d217cf14074366e964d98ee00',
     armv7l: '5af18c18464343ac82bc4ab201a81fd91c25ec6d217cf14074366e964d98ee00',
       i686: '4f4c1f5b2dbd71bf0be7df36ced3c3dbb8544259a3a7d273dee3e8a090c8b39f',
     x86_64: 'd2637e01530fa850baeab7ad29789f2df09f105b1f5defd0a9d59281e5cde73d'
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
