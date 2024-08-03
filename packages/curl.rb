require 'buildsystems/autotools'

class Curl < Autotools
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  version '8.9.1'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{version}.tar.xz"
  source_sha256 'f292f6cc051d5bbabf725ef85d432dfeacc8711dd717ea97612ae590643801e5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e02f8cc1a29cc87e9fe7b50c3cebad1a5d1639c58be3d9041b4d05745d553c9',
     armv7l: '2e02f8cc1a29cc87e9fe7b50c3cebad1a5d1639c58be3d9041b4d05745d553c9',
       i686: 'cf7cde9b2f35a3dcce5e013bb5db69307c26565e62f421e8cb0acec01aa5137b',
     x86_64: '3db3d860a9820bce793de1813718122616c0c2d1164e79082761dc3dae494a85'
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
