require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.15.0'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version.split('-').first}.tar.xz"
  source_sha256 'f4619a1e2474c4bbfedc88a7c2191209c8334b48fa1f4e53fd584cc12e9120dd'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6da2444366b8e4ff461d2ddd18983ee468f64a6b33a03aea4f6eb33e7f59ddbf',
     armv7l: '6da2444366b8e4ff461d2ddd18983ee468f64a6b33a03aea4f6eb33e7f59ddbf',
       i686: 'e3cabf83f352e25f2d3b723058c25efeaaa17c5d8959193ac1fda2a44ecdef01',
     x86_64: '00ba18b4ce283f2e74a1c08f7515ee61deca873e323e70fdf380818a7b5f25a9'
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
