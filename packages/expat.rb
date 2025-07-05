require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.7.1-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d629de2c55bd1f7535e19444e4af8d018c69b647905035a8bd2d801dfe053de',
     armv7l: '6d629de2c55bd1f7535e19444e4af8d018c69b647905035a8bd2d801dfe053de',
       i686: 'c218b06e2ce410241fca0ed6601d168fbd4c9d1b6e70fc78317763bea18472db',
     x86_64: '5b19dbd1ae39faf8561e29b9bc5ec4e8e8016d77278a806549fbb53412d6b2d4'
  })

  depends_on 'docbook2x' => :build
  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
