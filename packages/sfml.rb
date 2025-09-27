require 'buildsystems/cmake'

class Sfml < CMake
  description 'SFML is a simple, fast, cross-platform and object-oriented multimedia API.'
  homepage 'https://www.sfml-dev.org/'
  version '3.0.2'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/SFML/SFML.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fcde545d4a23359171c994cf44032a1707d2fefb0d1e9056c3c841785f738fea',
     armv7l: 'fcde545d4a23359171c994cf44032a1707d2fefb0d1e9056c3c841785f738fea',
     x86_64: '7d5fb83ac3623056140881425424e06fa0dfd7c8ca8f17ad1360fd78345877d9'
  })

  depends_on 'eudev' # R
  depends_on 'flac'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd'
  depends_on 'libogg' # R
  depends_on 'libvorbis'
  depends_on 'libx11'
  depends_on 'libxcursor'
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi'
  depends_on 'libxrandr'
  depends_on 'libxrender' # R

  cmake_options '-DBUILD_SHARED_LIBS=ON'
end
