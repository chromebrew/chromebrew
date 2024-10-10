require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.10.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'e6b142f0e85e954759d37e26a3627e2278137595be80e3a860c4353e4335e5a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41f71305a8e1667ba9d7aa72d9da94c2815519c1aeef5a38021b6df5d49df907',
     armv7l: '41f71305a8e1667ba9d7aa72d9da94c2815519c1aeef5a38021b6df5d49df907',
       i686: '564aec3780d562765584cdb919fe60805ecf26574d6452b8e1a75557e5ffe02e',
     x86_64: '6634a1a2f8c8979cf1e54638173a70a095e8ad5e4d346c706b4b419f4b607dfe'
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
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  configure_options "--disable-maintainer-mode \
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
