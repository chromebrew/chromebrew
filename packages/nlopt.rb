# Adapted from Arch Linux nlopt PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=nlopt

require 'buildsystems/cmake'

class Nlopt < CMake
  description 'nonlinear optimization library'
  homepage 'http://ab-initio.mit.edu/wiki/index.php/NLopt'
  version '2.10.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stevengj/nlopt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5d63cb98c4bdc8d602d12afa67ce13361bdcf139cb1dcc07df3e7078981aa48',
     armv7l: 'a5d63cb98c4bdc8d602d12afa67ce13361bdcf139cb1dcc07df3e7078981aa48',
     x86_64: 'c7d368c94742dc911fe359c2a960b89f81e12b77982bab19bb2b3486bd619a85'
  })

  depends_on 'gcc_lib' # R
  depends_on 'guile' => :build
  depends_on 'octave' # R
  depends_on 'py3_numpy' => :build
  depends_on 'swig' => :build

  cmake_options '-DNLOPT_MATLAB=OFF -DNLOPT_CXX=ON -DNLOPT_SWIG=OFF -DNLOPT_LINK_PYTHON=OFF'
end
