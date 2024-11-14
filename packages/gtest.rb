require 'buildsystems/cmake'

class Gtest < CMake
  description 'Google Test - C++ testing utility'
  homepage 'https://opensource.google/projects/googletest'
  version '1.15.2'
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/google/googletest.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee668998047fda174fcee58e90c399367ce8180f3c76c8758498996bf64b5e2a',
     armv7l: 'ee668998047fda174fcee58e90c399367ce8180f3c76c8758498996bf64b5e2a',
       i686: '542a15d9f5d6e1d5ca6848f48fa07030a7c419fc5b0cc6060f22348223f05f3e',
     x86_64: '5726830816ada7a1f5ed60bcc12011a76e40d5da03cba1ceed0c1aaf270c5882'
  })

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
