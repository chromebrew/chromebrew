require 'buildsystems/cmake'

class Check < CMake
  description 'A unit testing framework for C'
  homepage 'https://libcheck.github.io/check/'
  version '0.15.2-1'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/libcheck/check.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cedbac1abdb2c7588faaf4f2722c1f66908879356f9d3ddd5399688b402849c',
     armv7l: '4cedbac1abdb2c7588faaf4f2722c1f66908879356f9d3ddd5399688b402849c',
       i686: '27f945d6c18f20d3acd43bb87b4a69a2705cb76a3ba28effa73d7c5dc34532ed',
     x86_64: 'bd6f4fccc8e7395515bd6fe7a7365270e6878acb617dc8fc1ccc3ec961d6d786'
  })

  depends_on 'glibc' # R

  cmake_options '-DCHECK_ENABLE_TIMEOUT_TESTS=OFF'
end
