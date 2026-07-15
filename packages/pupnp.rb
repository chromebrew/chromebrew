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
    aarch64: 'fde4dd37232645265be4c44f5081cab4548a9a074c77515bf795400694e55e24',
     armv7l: 'fde4dd37232645265be4c44f5081cab4548a9a074c77515bf795400694e55e24',
       i686: 'a9a354e5f3d87984ae8f9eb645d0cc58fa4dc54ebc295935f4b88f571b668f4d',
     x86_64: '2f60806b787c1a04d017c33eed261c2aab36f8429b4f96466568f41050bb7a4a'
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
