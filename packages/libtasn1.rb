require 'buildsystems/autotools'

class Libtasn1 < Autotools
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.21.0'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libtasn1/libtasn1-#{version}.tar.gz"
  source_sha256 '1d8a444a223cc5464240777346e125de51d8e6abf0b8bac742ac84609167dc87'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f1b3df8f2a8b79f5efeb1a29da375176e285255567f6d70675c8f25c03f08c6',
     armv7l: '9f1b3df8f2a8b79f5efeb1a29da375176e285255567f6d70675c8f25c03f08c6',
       i686: 'e6367d85e8509f532c2b05c5d1a12c89f12052c1d6756193bceae7983b317697',
     x86_64: '8a1c6a8a45c795fccd5bd8856be2b443fde7d89f8ab70ab1135e608d1b1e7c53'
  })

  # bison, diff, cmp are required at compile-time
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'glibc' # R

  autotools_configure_options '--enable-shared \
      --enable-static \
      --with-pic'
end
