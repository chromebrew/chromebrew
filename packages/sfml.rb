require 'buildsystems/cmake'

class Sfml < CMake
  description 'SFML is a simple, fast, cross-platform and object-oriented multimedia API.'
  homepage 'https://www.sfml-dev.org/'
  version '3.0.0'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/SFML/SFML.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     x86_64: '44aaaab7168a8c1cf62d317f1a9760e6e0a2d76edf0e9be337b178b239b421fa'
  })

  depends_on 'flac'
  depends_on 'freetype'
  depends_on 'libglvnd'
  depends_on 'libvorbis'
  depends_on 'libx11'
  depends_on 'libxcursor'
  depends_on 'libxi'
  depends_on 'libxrandr'
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libogg' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxrender' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
