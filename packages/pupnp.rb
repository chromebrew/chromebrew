require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.1.5'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '118a7b5d6f11e50bf20dc60d5adeba7c80450b471cdb6f7eda597f10b3426aa9',
     armv7l: '118a7b5d6f11e50bf20dc60d5adeba7c80450b471cdb6f7eda597f10b3426aa9',
       i686: '49b2528309eea88a88e008be2112673cede5354936552eb1b34b02634829984c',
     x86_64: '849e0c485f8ec28c94583579a33a6cdd99b997b05945ec209d764ed7de99962e'
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
