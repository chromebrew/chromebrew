require 'buildsystems/cmake'

class Libtommath < CMake
  description 'LibTomMath is a free open source portable number theoretic multiple-precision integer library written entirely in C.'
  homepage 'https://www.libtom.net/'
  version '1.3.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/libtom/libtommath.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ecd409dd58b273ca59841f90f81652bada2c21a1234e8fd88b7516d3a4788ed',
     armv7l: '6ecd409dd58b273ca59841f90f81652bada2c21a1234e8fd88b7516d3a4788ed',
       i686: '29af46e3d69b34e226f7c3ae7567ab964cf810f299ac7a04fdf18f37fc988a90',
     x86_64: '3e6c9e04a3cb63f2d9f1cf98a1db575a6c46df08b30b022c4389dd4059d83a04'
  })

  depends_on 'glibc' => :library

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
