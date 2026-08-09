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
    aarch64: '0670fba04df26c8b3f74ee4101ec9427e3841af5daddc9ccb57576a8cfc46374',
     armv7l: '0670fba04df26c8b3f74ee4101ec9427e3841af5daddc9ccb57576a8cfc46374',
       i686: '757097eab284334a8148ab477c826a59795b5af543d8b0f4755c4ae791617c58',
     x86_64: '8c561418f9204f515fa54e3227822f9b3d2c48c304682d37613a537f1e16e721'
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
