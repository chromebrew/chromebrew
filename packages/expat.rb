require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.8.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23a0933b68486830db0278ce8af44cfdeea921d70340030c4a14987257b07d6f',
     armv7l: '23a0933b68486830db0278ce8af44cfdeea921d70340030c4a14987257b07d6f',
       i686: '67d2d2f1e1dbe1c7ac836fbb8eca5f8ab9b532b2712b92f8d5d796f6a65e0608',
     x86_64: '878b5491b8169aa82aefd23182993e015d826a19dafe94c03c8e907f68c32005'
  })

  depends_on 'glibc' => :library
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options "-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON \
          #{'-DEXPAT_DEV_URANDOM=ON' if ARCH == 'i686'}"
end
