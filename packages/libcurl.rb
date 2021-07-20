require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.77.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url 'https://github.com/curl/curl.git'
  git_hashtag 'curl-7_77_0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.77.0_armv7l/libcurl-7.77.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.77.0_armv7l/libcurl-7.77.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.77.0_i686/libcurl-7.77.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.77.0_x86_64/libcurl-7.77.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0acfb983b58fbffc1c94480b5b21b22013f8d853a649f3acadb1d6c41e34616c',
     armv7l: '0acfb983b58fbffc1c94480b5b21b22013f8d853a649f3acadb1d6c41e34616c',
       i686: '6aa358d2b91b50f758bd9908492d8b200cd3579da37056169f8edb4254d3cdf4',
     x86_64: '6f94ed40fb2853d5459e6b9513483f3794630ec6e61f64951311c57a4664b85a'
  })

  depends_on 'brotli' => :build
  depends_on 'ca_certificates' => :build
  depends_on 'c_ares' # R
  depends_on 'libcyrussasl' # R
  depends_on 'libidn2' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libssh' # R
  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    # Without these downstream programs which want to statically link
    # libcurl have issues.
    @krb5_static_libs = '-l:libkrb5support.a -l:libgssapi_krb5.a -l:libkrb5.a -l:libk5crypto.a -l:libcom_err.a'

    @libssh = '--with-libssh'
    case ARCH
    when 'i686'
      @libssh = '--without-libssh'
    end

    system '[ -x configure ] || autoreconf -fvi'
    system "env  CFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
       CXXFLAGS='-flto=auto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
       LDFLAGS='-flto=auto' LIBS='#{@krb5_static_libs} -lm -lbrotlicommon -lbrotlidec -lzstd -lz -lssl -lcrypto -lsasl2 -lxml2 -lpthread' \
       ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libmetalink \
      #{@libssh} \
      --with-openssl \
      --without-gnutls \
      --without-librtmp"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.rm "#{CREW_DEST_PREFIX}/bin/curl"
  end
end
