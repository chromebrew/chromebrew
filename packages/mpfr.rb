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
    aarch64: '5a7157000e960f6d449d697a654571d8de88a4210d5a59fa8501ff0c99741008',
     armv7l: '5a7157000e960f6d449d697a654571d8de88a4210d5a59fa8501ff0c99741008',
       i686: '058142ec3d1bd25d09fc887701647325ac51e3d21cf40ddd4464f713e341d641',
     x86_64: '50c33d094ae6b5f06096b05bebb9a86da72df20916831eaf95dd09b6752544f7'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' # R
  depends_on 'gmp' # R

  configure_options '--enable-shared'

  def self.check
    system "LD_LIBRARY_PATH=\$(pwd)/src/.libs:\$LD_LIBRARY_PATH make check"
  end
end
