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
    aarch64: '6ba3267ad21886c8a49608601bb26d350fdcc52c7fcb45c0c3707911387ef63d',
     armv7l: '6ba3267ad21886c8a49608601bb26d350fdcc52c7fcb45c0c3707911387ef63d',
       i686: 'eb58d652d1ed90103b75476004816a7570387dd4c1ccc32735107a9b0c541a52',
     x86_64: '4b06a71c5515ae5657c58cc45543d8ebbac6540c58f39504eb52dd7721892e12'
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
