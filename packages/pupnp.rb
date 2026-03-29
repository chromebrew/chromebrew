require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '1.18.4'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd0e35db6e0afa9d965dec8d063324dfd86b0a1f3d763718688c54480270da309',
     armv7l: 'd0e35db6e0afa9d965dec8d063324dfd86b0a1f3d763718688c54480270da309',
       i686: 'a348e870396a9a58cc29f89bcb2655b7dc948e7b539c9400554e4640dbf7a531',
     x86_64: 'e99762e6f47b368d9c27dc2bedf0fbec44826d260e66e9c1c0298227453594aa'
  })

  depends_on 'glibc' => :library
  depends_on 'gtest' => :build

  cmake_options "-DGTest_DIR=#{CREW_LIB_PREFIX}/cmake/GTest"
  run_tests
end
