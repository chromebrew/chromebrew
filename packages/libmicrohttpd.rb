require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 'a89e09fc9b4de34dde19f4fcb4faaa1ce10299b9908db1132bbfa1de47882b94'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9b72083e688cb547d069a1d8796751beb085ff47eb6535fcfa6fbfd5b8e4007',
     armv7l: 'c9b72083e688cb547d069a1d8796751beb085ff47eb6535fcfa6fbfd5b8e4007',
       i686: '0f3b8b82cf4f9707c877f2ca7758a5ad148c6ba24b892fb2a26276f3cc4d62bc',
     x86_64: '2f817d93c17190c753485e35df89b1f23da6c3b10c57e21610b13ff7a84ccdda'
  })

  depends_on 'diffutils' => :build
  depends_on 'glibc' # R
  depends_on 'gnutls' # R

  autotools_configure_options '--disable-examples'
end
