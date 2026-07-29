require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.8'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 '0763970a0e39f8f382123366e3cf5d03f70aa1e2208d3101e84da3e2cd674703'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '194ce0e26dc7a9ddb9a382e4a7d49062f7e068e62f483bfc19da61b5fd24b12a',
     armv7l: '194ce0e26dc7a9ddb9a382e4a7d49062f7e068e62f483bfc19da61b5fd24b12a',
       i686: 'ec3a7cbb5b9a8d480ab9f07136950e725e2df62487085eb68c1b1e6c45484a72',
     x86_64: '70a8cc968c267e000e3c87b6925c784cd4df105521c5838f9af1b097cd953062'
  })

  depends_on 'brotli' => :library
  depends_on 'diffutils' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gmp' => :library
  depends_on 'gnutls' => :library
  depends_on 'libidn2' => :library
  depends_on 'libtasn1' => :library
  depends_on 'libunistring' => :library
  depends_on 'nettle' => :library
  depends_on 'p11kit' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  autotools_configure_options "--disable-examples #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
