require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.0.3'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1762c2f8b9f45cc935c78d57ad964ae3c19960d5d5bcace1ceed8f7a7c9af3fa',
     armv7l: '1762c2f8b9f45cc935c78d57ad964ae3c19960d5d5bcace1ceed8f7a7c9af3fa',
       i686: 'ee1a222cbe61bad449a734b1c6eaa8802f1f9fc38627caa9831148f45e71b34b',
     x86_64: 'e06e68960847b0562699dc8c83ffb01eeff5de0ca8758578abfd32ce31ed80c4'
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
