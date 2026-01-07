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
    aarch64: 'e90834ca36db0b27f7dc334c1fdfe40b677ecad34b04d430530337b27fe8b859',
     armv7l: 'e90834ca36db0b27f7dc334c1fdfe40b677ecad34b04d430530337b27fe8b859',
       i686: '240eb773b87c9dd7405fa6d00b6becf7f9fd746f55e135888394df4d3e051424',
     x86_64: 'bf54caeba8bb8a1b1b602cce67c2cd2e9ce5518dc12959000360452e33d61bf1'
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
