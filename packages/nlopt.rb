# Adapted from Arch Linux nlopt PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=nlopt

require 'buildsystems/cmake'

class Nlopt < CMake
  description 'nonlinear optimization library'
  homepage 'http://ab-initio.mit.edu/wiki/index.php/NLopt'
  version '2.11.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stevengj/nlopt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8ddeeda1794ff2d065d79b2d55c0acd712244fde7268e540a14074c951181468',
     armv7l: '8ddeeda1794ff2d065d79b2d55c0acd712244fde7268e540a14074c951181468',
     x86_64: '1dcce44b4c7eaa38a9478a597215404c02e0a408c267e0d0dc4caaa712151281'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'guile' => :build
  depends_on 'octave' # R
  depends_on 'openjdk11' => :build
  depends_on 'py3_numpy' => :build
  depends_on 'python3' => :build
  depends_on 'swig' => :build
end
