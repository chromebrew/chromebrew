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
    aarch64: '3a7cbe0a66b3157bb2ea9466d259596a47dedba726eb8cacfa0eb108c0e2193a',
     armv7l: '3a7cbe0a66b3157bb2ea9466d259596a47dedba726eb8cacfa0eb108c0e2193a',
       i686: 'f5396561216b4239b294574b4a2da9acba5085e1e9df0bd1df715a6f2da54286',
     x86_64: '09de8ed9498e679401e930802c7e3742b695257bf7ca15d2e6abad3ba1205a26'
  })

  depends_on 'docbook2x' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON'
end
