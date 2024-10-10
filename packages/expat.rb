require 'buildsystems/cmake'

class Expat < CMake
  description 'James Clark\'s Expat XML parser library in C.'
  homepage 'https://github.com/libexpat/libexpat'
  version '2.6.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libexpat/libexpat.git'
  git_hashtag "R_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c05d2caeebaaae182d518d4081f774cfe11981f0cec3f95aba3b25aabb10e916',
     armv7l: 'c05d2caeebaaae182d518d4081f774cfe11981f0cec3f95aba3b25aabb10e916',
       i686: '067749fd15e6a154ff2eca8e9de0330a944d536f4f70316ed08d0e05a785b164',
     x86_64: '0683c473cc6a12e34a055669b5601d00221db0505e57368ef32f256fcbd04a30'
  })

  depends_on 'glibc' # R
  run_tests

  cmake_build_relative_dir 'expat'
  cmake_options '-DEXPAT_BUILD_EXAMPLES=OFF \
          -DBUILD_SHARED_LIBS=ON'
end
