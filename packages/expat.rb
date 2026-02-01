require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.7.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0753ec3b4e924f85eb39640dd84aaee17197c00a404de996db286a87bc46e28',
     armv7l: 'e0753ec3b4e924f85eb39640dd84aaee17197c00a404de996db286a87bc46e28',
       i686: '054a3de0e0f796c3eedd2f649f9ec6a37407a44408fbeb96cdd861b4c86ee3bc',
     x86_64: '125821ea7b38225b9902252f9f519a5172f7681958317883a5cf3d6949d5df0d'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
