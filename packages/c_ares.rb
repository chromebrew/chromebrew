require 'buildsystems/cmake'

class C_ares < CMake
  description 'C library for asynchronous DNS requests (including name resolves).'
  homepage 'https://c-ares.org/'
  version '1.34.9'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/c-ares/c-ares.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '327f39e3d7a3f1fedaeb9dc5ae01f3c54c68ec273626a12f08e6c3b3f5e64a92',
     armv7l: '327f39e3d7a3f1fedaeb9dc5ae01f3c54c68ec273626a12f08e6c3b3f5e64a92',
       i686: '03d64842c09ca39720313de3e6006f0947271c8d7b0192ebd907bb5c5e9e5f18',
     x86_64: '1dcc731986d0163e4acbe98429c40fe3ddcf9e7895d927a91ad8769b6272c01f'
  })

  depends_on 'docbook2x' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  cmake_options '-DCARES_BUILD_TESTS=OFF \
      -DCARES_BUILD_TOOLS=ON'
end
