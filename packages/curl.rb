require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.8.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.8.0.tar.xz'
  source_sha256 '0f58bb95fc330c8a46eeb3df5701b0d90c9d9bfcc42bd1cd08791d12551d4400'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea52214cfedebed8ac6de38de9934df891ebf5a110184b65f753478e644a40c8',
     armv7l: 'ea52214cfedebed8ac6de38de9934df891ebf5a110184b65f753478e644a40c8',
       i686: '095cd0acc9355d9c7dfe0903d5303f1b171677cf546b2ec9ac8fe1322ba894d0',
     x86_64: '1a2f0d2357b3c5c3df5f89349d7419454fba77434390c199e6ac82d324c57956'
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
  depends_on 'zlibpkg' # R
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
