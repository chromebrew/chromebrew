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
    aarch64: '1041c698980543371e9094575e668ad3a632ecc13dbc33b2b6283d526edc2e02',
     armv7l: '1041c698980543371e9094575e668ad3a632ecc13dbc33b2b6283d526edc2e02',
       i686: 'b21ce4a13d49b7ec551570c5345d05c7ad4a9274e3e6ba81a4edacd14a1af70f',
     x86_64: '2b55f5453d2b135e82f5fa8e1384be963040ce2dcfe59a2e2a1c7bef2efb72c3'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=ON \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DEXPAT_BUILD_TOOLS=ON \
          -DBUILD_SHARED_LIBS=ON'
end
