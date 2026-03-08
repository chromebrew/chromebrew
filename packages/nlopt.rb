# Adapted from Arch Linux nlopt PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=nlopt

require 'buildsystems/cmake'

class Nlopt < CMake
  description 'nonlinear optimization library'
  homepage 'http://ab-initio.mit.edu/wiki/index.php/NLopt'
  version '2.10.1'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/stevengj/nlopt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfc04694a16c0d3f268e2535cb751985aeea7b67d5fa3c12d0bbef052f1f4eec',
     armv7l: 'dfc04694a16c0d3f268e2535cb751985aeea7b67d5fa3c12d0bbef052f1f4eec',
     x86_64: '403aad9d25a98ee35f9bd9f9e0d28d43f1f879bb62d81ea743ff0155a9574d3c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'guile' => :build
  depends_on 'octave' # R
  depends_on 'openjdk11' => :build
  depends_on 'py3_numpy' => :build
  depends_on 'python3' => :build
  depends_on 'swig' => :build
end
