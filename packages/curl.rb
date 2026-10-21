require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.23.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 '8dadd7d2536a314f982ad05a651b713f426bf7d02cc2c76cffb9796f2218e6c5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9c56ea96f2858668cde8d82452dc9b5fd54d442482742d26e1fea21f6cbcf2df',
     armv7l: '9c56ea96f2858668cde8d82452dc9b5fd54d442482742d26e1fea21f6cbcf2df',
       i686: 'd432934e08eb58e8177fdd621f730de2353e8cc1300eeaa43fef4ebbf2b4e1a2',
     x86_64: '7fe41473b93e08701b5ce75dbf65c170c3a6399cd06abf710ba28e7b445c06d5'
  })

  depends_on 'brotli' => :library
  depends_on 'c_ares' => :library
  depends_on 'ca_certificates' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libcyrussasl' => :executable
  depends_on 'libcyrussasl' => :library
  depends_on 'libidn2' => :library
  depends_on 'libnghttp2' => :library
  depends_on 'libnghttp3' => :library
  depends_on 'libngtcp2' => :library
  depends_on 'libpsl' => :library
  depends_on 'libssh' => :library
  depends_on 'libunistring' => :executable
  depends_on 'libunistring' => :library
  depends_on 'openldap' => :library
  depends_on 'openssl' => :library
  depends_on 'python3' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library

  def self.patch
    # Get the current Mozilla CA certificates pem from
    # https://curl.se/docs/caextract.html, which is also in the
    # ca_certificates package.
    downloader 'https://curl.se/ca/cacert.pem', 'SKIP', "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
  end

  autotools_configure_options "--disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-embed=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-ngtcp2 \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
end
