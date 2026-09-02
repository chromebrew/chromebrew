require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.5.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd85fda812802d4d070c273e64113d2734a81168864a934a6cd13aee673d1009a',
     armv7l: 'd85fda812802d4d070c273e64113d2734a81168864a934a6cd13aee673d1009a',
       i686: '30f82260fdf4ef6eeb6763e2bdf8a94d729a9f1d12a5d02cfddad2189bdc9f88',
     x86_64: '30bef158740adfc3e7ab47b7a752039e6ff4f1065e5c8d7d49a29b01c17c7517'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
