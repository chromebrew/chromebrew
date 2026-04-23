require 'buildsystems/cmake'

class Pupnp < CMake
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '1.18.5'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88a80eb3759a72de6cc35fa3fe36d33f0f26a9c77d9d3e84d27303461ccb3af7',
     armv7l: '88a80eb3759a72de6cc35fa3fe36d33f0f26a9c77d9d3e84d27303461ccb3af7',
       i686: 'bf9e62da273b1e4c76c18c2727ccd4c242b973f0a8acc50cf1d0e65956b6d1be',
     x86_64: '7c04e08140438c62a9717a2257d5108df5aff19efaa4e933c813cf8dc35c2642'
  })

  depends_on 'glibc' => :library
  depends_on 'gtest' => :build

  cmake_options "-DGTest_DIR=#{CREW_LIB_PREFIX}/cmake/GTest"
  run_tests
end
