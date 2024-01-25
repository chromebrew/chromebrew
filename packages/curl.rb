require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.5.0'
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.5.0.tar.xz'
  source_sha256 '42ab8db9e20d8290a3b633e7fbb3cec15db34df65fd1015ef8ac1e4723750eeb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'edcd12652578507a20da5fffd4ba2b33b2fe0f681070f9a334efc97970f08ce8',
     armv7l: 'edcd12652578507a20da5fffd4ba2b33b2fe0f681070f9a334efc97970f08ce8',
       i686: 'a07f7983b8448fb12bbe0fc0a74ce0992f566d51488c2e73742ad5443c1c5510',
     x86_64: 'e48a1d65575457eb66e1b165f285b75b3b6303ae7efef3e7b57da2ff2fcdad1d'
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
