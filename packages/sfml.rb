require 'buildsystems/cmake'

class Sfml < CMake
  description 'SFML is a simple, fast, cross-platform and object-oriented multimedia API.'
  homepage 'https://www.sfml-dev.org/'
  version '3.0.1'
  license 'zlib'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/SFML/SFML.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18d0db77e3d0ae5ad0e5e7a89497e5e1ddc3b3c8a024ae836db8f6537e433035',
     armv7l: '18d0db77e3d0ae5ad0e5e7a89497e5e1ddc3b3c8a024ae836db8f6537e433035',
     x86_64: 'dca53b12066dae1caa17bd0bdd79e6ef6f56ed3a95d1c56cc242d2459533dfa2'
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
