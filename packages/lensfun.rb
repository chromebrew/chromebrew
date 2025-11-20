# Adapted from Arch Linux lensfun PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/lensfun/trunk/PKGBUILD

require 'buildsystems/cmake'

class Lensfun < CMake
  description 'Database of photographic lenses and a library that allows advanced access to the database'
  homepage 'https://lensfun.github.io/'
  version '0.3.4'
  license 'LGPL3'
  compatibility 'all'
  source_url 'https://github.com/lensfun/lensfun.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cbf625098b91e0e66ba753f6392ad1471124e2fead206fee90b16cde5d3dc81',
     armv7l: '6cbf625098b91e0e66ba753f6392ad1471124e2fead206fee90b16cde5d3dc81',
       i686: 'f2122684ec0cd6e4495d107f0ee4588e27c444597c1b9c912aca95a13e680aff',
     x86_64: '52ec983058bd351f0da8dc9c5aaa78b7030847cac302ebe7b5121f749a14d1d7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libpng' => :build

  cmake_options '-DCMAKE_POLICY_VERSION_MINIMUM=3.5'
end
