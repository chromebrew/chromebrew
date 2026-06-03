require 'buildsystems/autotools'

class Mpc < Autotools
  description 'Gnu Mpc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result.'
  homepage 'https://www.multiprecision.org'
  version '1.4.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/mpc/mpc-#{version}.tar.xz"
  source_sha256 '91204cd32f164bd3b7c992d4a6a8ce6519511aadab30f78b6982d0bf8d73e931'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79810ccbd42e9b9ba49116131662278b50b8745b595a8af6a5cf8eb596d8d3c4',
     armv7l: '79810ccbd42e9b9ba49116131662278b50b8745b595a8af6a5cf8eb596d8d3c4',
       i686: '64e3b21c1c5863a658f0643487e47b1309108c2723777dee55e096ebf176d7cd',
     x86_64: 'c92f5d28994238579c9c812168a6cafd644cc486842d1b70938b391222f59131'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'mpfr' => :library

  autotools_configure_options '--disable-maintainer-mode \
      --enable-shared'
end
