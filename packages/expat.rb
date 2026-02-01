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
    aarch64: '4611ef350e0d941a4d9dd18ab4b34d5a67f1c2a0058910d89bff6b3476559b16',
     armv7l: '4611ef350e0d941a4d9dd18ab4b34d5a67f1c2a0058910d89bff6b3476559b16',
       i686: '3365f72ccd796bfbb6e4ad2c1f20ba52cf57e550892d44d3520a020c69e4e5cc',
     x86_64: '604f2bd4bb421643cb4a84856096e1c86cc5bdfadae6b33dc01fb082cc76dd04'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_DOCS=OFF \
          -DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
