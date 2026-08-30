require 'buildsystems/cmake'

class Gmic < CMake
  description "GREYC's Magic for Image Computing: A Full-Featured Open-Source Framework for Image Processing"
  homepage 'https://gmic.eu/'
  version '4.0.4'
  license 'CeCILL and CeCILL-C'
  compatibility 'x86_64'
  source_url 'https://github.com/GreycLab/gmic.git'
  git_hashtag "v.#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '64e3659c392430ce58552e66489208aefb92112dd10982b482d120d002a9dfd4'
  })

  depends_on 'curl' => :library
  depends_on 'fftw' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'graphicsmagick' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libtiff' => :library
  depends_on 'libx11' => :library
  depends_on 'openexr' => :library
  depends_on 'zlib' => :library

  # For whatever reason, the man page build fails with
  # error while loading shared libraries: libfftw3.so.3
  cmake_options '-DBUILD_BASH_COMPLETION=OFF -DBUILD_LIB=ON -DBUILD_MAN=OFF'
end
