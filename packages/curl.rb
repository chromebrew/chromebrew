require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.77.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 '0f64582c54282f31c0de9f0a1a596b182776bd4df9a4c4a2a41bbeb54f62594b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0_armv7l/curl-7.77.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0_armv7l/curl-7.77.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0_i686/curl-7.77.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0_x86_64/curl-7.77.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0273d3cf0ffb3d18777bb4d5da6a20c00970ad3787687e48c023f406aa42d4bc',
     armv7l: '0273d3cf0ffb3d18777bb4d5da6a20c00970ad3787687e48c023f406aa42d4bc',
       i686: 'ead35292354673e20806e70a9359306bd63758a04db3888eb5eca7c99cd1904a',
     x86_64: '81b8641d60b222248a75f910e2bf82ce7b9d793a84558466e7670215bbd9b8d1'
  })

  depends_on 'libunbound' # ?
  depends_on 'openldap' # R
  depends_on 'openssl' # R
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    @krb5_static_libs = "#{CREW_LIB_PREFIX}/libkrb5support.a " + "#{CREW_LIB_PREFIX}/libgssapi_krb5.a " + "#{CREW_LIB_PREFIX}/libkrb5.a " + "#{CREW_LIB_PREFIX}/libk5crypto.a " + "#{CREW_LIB_PREFIX}/libcom_err.a "

    FileUtils.mkdir 'ssl'
    FileUtils.ln_s "#{CREW_PREFIX}/include/openssl", 'ssl/include'
    FileUtils.ln_s CREW_LIB_PREFIX, 'ssl/lib'
    @sslpath = "#{`pwd`.chomp}/ssl"
    system 'filefix'
    system "env CC=clang CXX=clang++ LD=ld.lld RANLIB=llvm-ranlib \
      AR=llvm-ar \
      CFLAGS='-flto -pipe -O3 -lz -fuse-ld=lld' \
      CXXFLAGS='-flto -pipe -O3' \
      LDFLAGS='-flto -static -Wl,--no-as-needed -ldl' LIBS='-l:libresolv.a #{@krb5_static_libs} -l:libzstd.a -l:libssh.a -lm -lbrotlicommon -lbrotlidec -lz -lssl -lcrypto -lsasl2 -lxml2 -lpthread' \
      ./configure #{CREW_OPTIONS} \
      --disable-ldap \
      --disable-libcurl-option \
      --disable-maintainer-mode \
      --disable-shared \
      --enable-ipv6 \
      --enable-static \
      --enable-unix-sockets \
      --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
      --with-ca-fallback \
      --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
      --with-libssh \
      --with-openssl \
      --without-librtmp"
    system 'make curl_LDFLAGS=-all-static'
    FileUtils.cp 'src/curl', 'curl.static'
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
      --with-lber-lib=lber \
      --with-ldap-lib=ldap \
      --with-libmetalink \
      --with-libssh \
      --with-openssl=#{@sslpath} \
      --without-gnutls \
      --without-librtmp"
    system 'make'
  end

   def self.check
     # Python package impacket needed for testing.
     # 1094 tests out of 1097 reported OK: 99% on 10/25/2020
     # The 3 tests that failed were FTP, SMB and GOPHER.
     system 'pip3 install impacket'
     system 'make check || true'
     system 'pip3 uninstall -y impacket'
   end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.install 'curl.static', "#{CREW_DEST_PREFIX}/bin/curl", mode: 0o755
  end
end
