require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.6'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 'bb5cfcadfc52dbd5eb512d6e2995e0361351c33e97a87aba426d3a4a7ba6cf70'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9406605fb99b6951e0472a83250ddc0320a8e87d2546ac08ac5dd95295ce3909',
     armv7l: '9406605fb99b6951e0472a83250ddc0320a8e87d2546ac08ac5dd95295ce3909',
       i686: 'd178233e6de9dcd969775401eca82d948684a7d6c3d5bb53e0991fc3ae107fb1',
     x86_64: 'd253213ce82f12e2a209ceba9d8cf22ea3131d9446cab2d31f37de45b27d0de4'
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
