require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '1.18.4'
  compatibility 'aarch64 armv7l x86_64'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55ec8e02bdd3792916474fc6128076dec992b110eb4a6b1e04536ab1110aef7e',
     armv7l: '55ec8e02bdd3792916474fc6128076dec992b110eb4a6b1e04536ab1110aef7e',
     x86_64: 'b02529117a5f466b3da98dd9325de790c811b6848c2ab23b6e69fb6f3a8fe602'
  })

  depends_on 'glibc' => :library
  depends_on 'gtest' => :build

  cmake_options "-DGTest_DIR=#{CREW_LIB_PREFIX}/cmake/GTest"

  run_tests
end
