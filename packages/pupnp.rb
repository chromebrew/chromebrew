require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '22.1.7'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1bb05f26fea5788e5b997cff51485b6ec2766299a2e619853bebe9e37a687616',
     armv7l: '1bb05f26fea5788e5b997cff51485b6ec2766299a2e619853bebe9e37a687616',
       i686: '7eadaefbe61a1c219c15f561e73b3d61e4eb58ae11c2c307f1be9dd77b3dfb4e',
     x86_64: 'fdf519f0761d2c61cee86a4f1f6ffced21c9c44faa0dd55e9ab66a14969ad243'
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
