require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.org/'
  version '1.34.8'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25b240c7175ce092ae5f7fb5c803f80e3965b09c718c9279aae442ef9a0ccb03',
     armv7l: '25b240c7175ce092ae5f7fb5c803f80e3965b09c718c9279aae442ef9a0ccb03',
       i686: '679056ea5925b3c0e0ad41f70b49fbd0f0d7b08bcc35f068899f0ec17015a355',
     x86_64: '953268127732893c4c7c8433794d808926e328530adf764d54ff8ed632d08f6f'
  })

  depends_on 'docbook2x' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON'
end
