require 'buildsystems/cmake'

class Tinyxml2 < CMake
  description 'TinyXML2 is a simple, small, efficient, C++ XML parser that can be easily integrated into other programs.'
  homepage 'https://github.com/leethomason/tinyxml2'
  version '11.0.0'
  license 'zlib'
  compatibility 'all'
  source_url 'https://github.com/leethomason/tinyxml2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b26020b300b0bdc9bae4eab3fde373b2f68072850f9e8c8ca370c679c03eb565',
     armv7l: 'b26020b300b0bdc9bae4eab3fde373b2f68072850f9e8c8ca370c679c03eb565',
       i686: 'b05ae0956166ca1e32a8c4b1cf22b12d7c1958191a1fcd4e40659ab7ed660d9f',
     x86_64: '1500d2d2679759ea218f95cafb892fbde5baf4560b085fb1225171a69035c6d2'
  })

  cmake_options '-DBUILD_SHARED_LIBS=ON'
  run_tests
end
