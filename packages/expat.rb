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
    aarch64: 'dbdc58eff57f4b3c4728bbda3acc94cfe5b5c96001702a02131036edd747f97e',
     armv7l: 'dbdc58eff57f4b3c4728bbda3acc94cfe5b5c96001702a02131036edd747f97e',
       i686: '0af461985db7d37341d230d1e0fa38324131ee653a8e978f87bc5020314eeb05',
     x86_64: '789aeefda1a0fca1b9acbf5a637659bbcef2d17b9ec1855ea3d031fdf93c7849'
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
