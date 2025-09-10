require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.16.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version.split('-').first}.tar.xz"
  source_sha256 '40c8cddbcb6cc6251c03dea423a472a6cea4037be654ba5cf5dec6eb2d22ff1d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cb03956efe01d6db11e011f178257405c917be4fdfd8e881e55350ddc337ddc',
     armv7l: '5cb03956efe01d6db11e011f178257405c917be4fdfd8e881e55350ddc337ddc',
       i686: 'c7b7dda34f0415f2d7b4307a8f22b6f643d643b3cff6ba30d6c27bd61f0bbb11',
     x86_64: '884d27a6562b78d0aabaf6f8356fe9cc4d47ddaa2883bac0a46e871b5e728113'
  })

  depends_on 'brotli' # R
  depends_on 'c_ares' # R
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
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
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
