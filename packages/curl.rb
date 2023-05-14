require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '8.0.1'
  version "#{@_ver}-1"
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-8.0.1.tar.xz'
  source_sha256 '0a381cd82f4d00a9a334438b8ca239afea5bfefcfa9a1025f2bf118e79e0b5f0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1-1_armv7l/curl-8.0.1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1-1_armv7l/curl-8.0.1-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1-1_i686/curl-8.0.1-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/8.0.1-1_x86_64/curl-8.0.1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7abe4fb18e0f8e1e7c6b3eebfc7bdbc3e796b3c3401c325fa478d9fd4b348358',
     armv7l: '7abe4fb18e0f8e1e7c6b3eebfc7bdbc3e796b3c3401c325fa478d9fd4b348358',
       i686: '6c8fcc1fb9563f9ca8eda52296672a5a74b099cd26cb820a245aecd2d2792255',
     x86_64: 'c095e8a0910b840c949de5cc0829bdfcc004c83bcfb49332a827325688ec40e0'
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

  def self.build
    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "mold -run ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
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
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
