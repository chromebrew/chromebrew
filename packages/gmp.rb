require 'buildsystems/autotools'

class Gmp < Autotools
  description 'GMP is a free library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating-point numbers.'
  homepage 'https://gmplib.org/'
  version '6.3.0' # Do not use @_ver here, it will break the installer.
  license 'LGPL-3+ and GPL-2+'
  compatibility 'all'
  source_url 'https://gmplib.org/download/gmp/gmp-6.3.0.tar.zst'
  source_sha256 '7f55d73f472c29cc14d7fa985f3654d48829415b649eaf61646b7b33f2a80e27'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32a4e78e10e6d20a42764a205e2334001d4bfec896dccac705313da8cd327fdf',
     armv7l: '32a4e78e10e6d20a42764a205e2334001d4bfec896dccac705313da8cd327fdf',
       i686: 'd165a4a8b2cdd49592ae3b88ff2709f1e6ce99f227f6fefcba86c1563f9e6ad4',
     x86_64: 'd4240bcc61b5901ab86c15b28e320c72ae470bfc20d415471d20cb90b2456753'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  configure_options '--disable-maintainer-mode \
      --enable-cxx'
end
