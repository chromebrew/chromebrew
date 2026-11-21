require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.11'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 'f227a044b75688e449b58ddedf0582255cc562899ff69f173a8ef76439744b4e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd652ddad6a231dd885e8eba003772ab24f87c8010a8dede04d6943cd04b9c48f',
     armv7l: 'd652ddad6a231dd885e8eba003772ab24f87c8010a8dede04d6943cd04b9c48f',
       i686: 'f79547edee8d3583864bd18193801b9b18fd1636846e7cc0c6fdc0b11de26431',
     x86_64: '56b84c16258e4315afea980fc766e5e90ddaf51607611149547b1b5ba5675117'
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
