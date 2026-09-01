require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.8.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70fa7c95abefa28957792cf0d6561a80bcbd2edc4a10dcbb254025438804c2fb',
     armv7l: '70fa7c95abefa28957792cf0d6561a80bcbd2edc4a10dcbb254025438804c2fb',
       i686: '68f4a9adf01ae8042a00704c4a1823b39fa167c426d2b9d99aff17502a0dadaa',
     x86_64: 'd0496c9ca051611d175a65467316be3a92ff6aa832f561569baa79cf806ecbaf'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options "-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON \
          #{'-DEXPAT_DEV_URANDOM=ON' if ARCH == 'i686'}"
end
