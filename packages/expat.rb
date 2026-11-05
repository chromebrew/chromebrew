require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.10.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd02c2059984331a1ee8de6f909eebb5e2554b9149b6e0a180b09fc280121685f',
     armv7l: 'd02c2059984331a1ee8de6f909eebb5e2554b9149b6e0a180b09fc280121685f',
       i686: '447ae0d04d48100a2a76ce8539cc2bf758ef499911764fdf444f8493f5afcad9',
     x86_64: 'dc9fbebd3eb19c76bf6b4b66ece5c624f22d100dfa4e32c1e76fdc23146d1acf'
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
