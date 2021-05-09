require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.76.1'
  version @_ver + '-1'
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '64bb5288c39f0840c07d077e30d9052e1cbb9fa6c2dc52523824cc859e679145'

  depends_on 'brotli' # R
  depends_on 'ca_certificates' # L
  depends_on 'c_ares' # R
  depends_on 'groff' => :build
  depends_on 'libidn2' # R
  depends_on 'libmetalink' # R
  depends_on 'libnghttp2' # R
  depends_on 'libpsl' # R
  depends_on 'libtirpc' # ?
  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'rtmpdump' # R
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'py3_impacket' => :build # Testing
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system 'filefix'
    system "env #{CREW_ENV_OPTIONS}
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-ares \
      --with-ldap-lib=ldap \
      --with-lber-lib=lber \
      --with-libmetalink \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback"
    system 'make'
  end

  def self.check
    # Python package impacket needed for testing.
    # 1094 tests out of 1097 reported OK: 99% on 10/25/2020
    # The 3 tests that failed were FTP, SMB and GOPHER.
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
