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
    aarch64: 'eecda9a8b2b6958c8f7fa9cc0b8d4c02583ad5f8f2645af86a90cb14d0c28cf3',
     armv7l: 'eecda9a8b2b6958c8f7fa9cc0b8d4c02583ad5f8f2645af86a90cb14d0c28cf3',
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
