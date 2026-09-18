require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.5.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca2c8c71dd6ab2a202fc1d8c74ba52904a6938ab37f564ed3af7424e6cd35a29',
     armv7l: 'ca2c8c71dd6ab2a202fc1d8c74ba52904a6938ab37f564ed3af7424e6cd35a29',
       i686: 'dc20fc913abf9609d267b696f1bf060dea14e9fcf8c568cc16e7a750d9552a76',
     x86_64: '5148acabc80978d70cbdd85738a5aad442bbc046a0e9d57909d0e27874962996'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
