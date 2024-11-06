require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-1.0.0.tar.gz'
  source_sha256 'a02792d3cd1520e2ecfed9df642079d44a36ed87167442b28d7ed19e906e3e96'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b2623ef36b1587c1d3e6f7821d4d9d016b7cadbaf6a0442fd0f055dd69338925',
     armv7l: 'b2623ef36b1587c1d3e6f7821d4d9d016b7cadbaf6a0442fd0f055dd69338925',
       i686: '97798a780803f029b9bc17f2f687da43d8f23c1ab6e27e6606f3bf8c16e06abc',
     x86_64: 'f8dbc8399732197b0152fda7114ae969627b3ae4501f1d20b67669d892d58f8d'
  })

  depends_on 'diffutils' => :build
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
end
