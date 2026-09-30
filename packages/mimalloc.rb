require 'buildsystems/cmake'

class Mimalloc < CMake
  description 'General-purpose allocator with excellent performance characteristics'
  homepage 'https://github.com/microsoft/mimalloc'
  version '3.5.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/microsoft/mimalloc.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8909a90594618cd9acab391ec17edec58e4c40d08030d95cf3adaf539a8c69a',
     armv7l: 'a8909a90594618cd9acab391ec17edec58e4c40d08030d95cf3adaf539a8c69a',
       i686: 'c8cf9a87b9d88e74aee2791bd4b3c85c737bb5718b4727ead81ecec5a28fba95',
     x86_64: 'fd27cf1d94f2995c79b5d9a7c165eb1af96dc06caacb3068fd445451e50b87af'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DMI_BUILD_TESTS=OFF'
end
