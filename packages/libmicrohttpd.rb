require 'buildsystems/autotools'

class Libmicrohttpd < Autotools
  description 'GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application.'
  homepage 'https://www.gnu.org/software/libmicrohttpd/'
  version '1.0.5'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-#{version}.tar.gz"
  source_sha256 'b46d00f58efa6f497b97d2e782c4ee66301d412ddd855dd3068518b3a2cd3ea2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12b3eced7f0b826fe4649ebbb6f8ae7e9d279a3cd904c30673ce58dc19227f3a',
     armv7l: '12b3eced7f0b826fe4649ebbb6f8ae7e9d279a3cd904c30673ce58dc19227f3a',
       i686: 'f1629abcd12020e6790ff5204b7576f12524adaefd3e2a6a4ddcbeea46e3c915',
     x86_64: '29cc46ad08bd2466b7a8599558d57b28c37db43ebb7af344d92560f4d5dbe580'
  })

  depends_on 'diffutils' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gnutls' => :library

  autotools_configure_options "--disable-examples #{'--disable-year2038' unless 'x86_64'.include?(ARCH)}"
end
