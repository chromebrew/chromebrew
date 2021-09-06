require 'package'

class Libcurl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.78.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url 'https://curl.se/download/curl-7.78.0.tar.xz'
  source_sha256 'be42766d5664a739c3974ee3dfbbcbe978a4ccb1fe628bb1d9b59ac79e445fb5'


  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.78.0_i686/libcurl-7.78.0-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.78.0_armv7l/libcurl-7.78.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.78.0_armv7l/libcurl-7.78.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcurl/7.78.0_x86_64/libcurl-7.78.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: '07f1ab7fd175cf911dbd0a2eb802b827f7b47f62b1aa65659b8a544b20dfcc6d',
    aarch64: '62cb453539ce7d575438bad5b565e6401614a0ef19c8979e954543719e710dbb',
     armv7l: '62cb453539ce7d575438bad5b565e6401614a0ef19c8979e954543719e710dbb',
     x86_64: '267da90a48c7e68051376a5f2febc39ad0c0265231afc567d6edd88ccb864760'
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
    # @krb5_static_libs = '-l:libkrb5support.a -l:libgssapi_krb5.a -l:libkrb5.a -l:libk5crypto.a -l:libcom_err.a'

    @libssh = '--with-libssh'
    case ARCH
    when 'i686'
      @libssh = '--without-libssh'
    end

    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --enable-ipv6 \
      --enable-ldap \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
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
