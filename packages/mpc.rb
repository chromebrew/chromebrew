require 'buildsystems/autotools'

class Mpc < Autotools
  description 'Gnu Mpc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result.'
  homepage 'https://www.multiprecision.org'
  version '1.3.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/mpc/mpc-#{version}.tar.gz"
  source_sha256 '17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2083196d2ce35edf739c9a324f3fb73474de7bff8a8c9446d05b0d53f465b9b',
     armv7l: 'e2083196d2ce35edf739c9a324f3fb73474de7bff8a8c9446d05b0d53f465b9b',
       i686: 'a9ffe02042d34189cee4e4015be7ab3c3541c0db15ad4c7e27ee57bd0314cbe4',
     x86_64: '57493dcf7256ec86735f554da1bdb1255c7c46329cf4d52cbbd44cd74f6326c3'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'mpfr' # R

  autotools_configure_options '--disable-maintainer-mode \
      --enable-shared'
end
