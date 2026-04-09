require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.19.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version.split('-').first}.tar.xz"
  source_sha256 '4eb41489790d19e190d7ac7e18e82857cdd68af8f4e66b292ced562d333f11df'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40386bab6f076e0a205a2c38a465c7ac05ddd54ab1e59071405ade4471906e60',
     armv7l: '40386bab6f076e0a205a2c38a465c7ac05ddd54ab1e59071405ade4471906e60',
       i686: 'd7b45f9f08c221754540c71768199f3a59b7823398bf1203fd5a8adef765f3b8',
     x86_64: 'da8de400a86808e57e67c6ed0f32b4aec8a8a5646d7292aa8dfb829dac5928a8'
  })

  depends_on 'brotli' => :library
  depends_on 'c_ares' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' => :library
  depends_on 'libidn2' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libnghttp3' => :library
  depends_on 'libngtcp2' => :library
  depends_on 'libpsl' => :library
  depends_on 'libssh' => :library
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'python3' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

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
