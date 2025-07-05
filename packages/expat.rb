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
       i686: 'b21ce4a13d49b7ec551570c5345d05c7ad4a9274e3e6ba81a4edacd14a1af70f',
     x86_64: '2b55f5453d2b135e82f5fa8e1384be963040ce2dcfe59a2e2a1c7bef2efb72c3'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DEXPAT_BUILD_TOOLS=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
