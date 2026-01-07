require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.18.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version.split('-').first}.tar.xz"
  source_sha256 '40df79166e74aa20149365e11ee4c798a46ad57c34e4f68fd13100e2c9a91946'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '287d58b7cf6e2554b95fe905364dcb787fd78bf233ec205c97dc8c3ed533dca0',
     armv7l: '287d58b7cf6e2554b95fe905364dcb787fd78bf233ec205c97dc8c3ed533dca0',
       i686: 'bb4a7e8d515a8da6c3ce13d970fbddc5eb565376c5e22e34302dc1b2b88a02a7',
     x86_64: '499d5af908ade27a2305632d09e4b91dc6ded47a6673784571afd5a3a8fc2484'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libnghttp3' # R
  depends_on 'libngtcp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
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
      --with-ngtcp2 \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
