require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.10'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 '04bfe8ef75db7d629a33de767599765cecadc56274a39822d5d081030d577685'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b2ca4cb0f4ac3616450eeaad8c24b86afce76b1bf34de9f7727a2cc137ee762',
     armv7l: '6b2ca4cb0f4ac3616450eeaad8c24b86afce76b1bf34de9f7727a2cc137ee762',
       i686: '488881b4d23262e50b21d251e8f46e9226b800ec428e1e514d11c7ae2b44aab0',
     x86_64: '95e6d3809b310f8ff0bf95c4695db8072061e9b5a776f86ba01a1b74c9be888f'
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
