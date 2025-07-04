require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.14.1-1'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version.split('-').first}.tar.xz"
  source_sha256 'f4619a1e2474c4bbfedc88a7c2191209c8334b48fa1f4e53fd584cc12e9120dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '076201b4d3ed37ed9b8c563f9c202e283753bd9606006423331c5f35568764b7',
     armv7l: '076201b4d3ed37ed9b8c563f9c202e283753bd9606006423331c5f35568764b7',
       i686: '698da555b8468744759e2c6ba215c1e7347da251c3f0c93e35df36cf9690b446',
     x86_64: 'b1e0460a226ad85e0b0f4f70412a05191843bd4cd36ea8ebd866d20873a79ed3'
  })

  depends_on 'brotli' # R
  depends_on 'ca_certificates' => :build
  depends_on 'c_ares' # R
  depends_on 'glibc' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunistring' # R
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'python3' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options "--disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
