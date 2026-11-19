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
    aarch64: '55c5038960d7ffe104a64ba29608c037301a4986cb2e04918b386b8aa9366ce6',
     armv7l: '55c5038960d7ffe104a64ba29608c037301a4986cb2e04918b386b8aa9366ce6',
       i686: '6e8470167609a8d735908dfe848522770a23d67ae0ae22a21aea62ef17a49478',
     x86_64: 'd4c24091b3828a7fb9da624daaf342439198ff8617f50ea9f257cfbb9e1570de'
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
