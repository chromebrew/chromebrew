# Adapted from Arch Linux nlopt PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=nlopt

require 'buildsystems/cmake'

class Nlopt < CMake
  description 'nonlinear optimization library'
  homepage 'http://ab-initio.mit.edu/wiki/index.php/NLopt'
  version '2.8.0'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stevengj/nlopt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a5bf199ecc5efc14f09291e63e5a76f203f5eeed5ccf439e33dddedd869ea9db',
     armv7l: 'a5bf199ecc5efc14f09291e63e5a76f203f5eeed5ccf439e33dddedd869ea9db',
     x86_64: '1496c02e877846e402cd8de0fabc917e1912ca9b73f977861fd58fc272be2e6f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'guile' => :build
  depends_on 'octave' # R
  depends_on 'py3_numpy' => :build
  depends_on 'swig' => :build

  cmake_options '-DNLOPT_MATLAB=OFF -DNLOPT_CXX=ON -DNLOPT_SWIG=OFF -DNLOPT_LINK_PYTHON=OFF'
end
