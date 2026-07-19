require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.0.4'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5b603df9a9b0dc2b214d7df713b250838ddfb3d61d1ad3238ad2f76b6a182a4',
     armv7l: 'a5b603df9a9b0dc2b214d7df713b250838ddfb3d61d1ad3238ad2f76b6a182a4',
       i686: '11b3a1d217db26e91739e6198707b26ca3c0c10e51f9603886fee9ac1661fecf',
     x86_64: 'c94a9afda4cb87f0be088994d05b72e99da23616c0ef20f55789e2eeabdfada9'
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
