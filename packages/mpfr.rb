require 'buildsystems/autotools'

class Mpfr < Autotools
  description 'The MPFR library is a C library for multiple-precision floating-point computations with correct rounding.'
  homepage 'https://www.mpfr.org/'
  version '4.2.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.mpfr.org/mpfr-current/mpfr-#{version}.tar.xz"
  source_sha256 '277807353a6726978996945af13e52829e3abd7a9a5b7fb2793894e18f1fcbb2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a8fbf432ec14ab1641c76bbe4d152ebf4382870c85214fc3dd62dd57207f8e4',
     armv7l: '0a8fbf432ec14ab1641c76bbe4d152ebf4382870c85214fc3dd62dd57207f8e4',
       i686: '058142ec3d1bd25d09fc887701647325ac51e3d21cf40ddd4464f713e341d641',
     x86_64: 'c9f4ba6d151d330702384bd29b3cf080b357dbf8da6be06597f57f00d21750a0'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R
  depends_on 'gmp' # R

  configure_options '--enable-shared'

  def self.check
    system "LD_LIBRARY_PATH=\$(pwd)/src/.libs:\$LD_LIBRARY_PATH make check"
  end
end
