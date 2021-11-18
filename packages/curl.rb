require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.80.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://curl.se/download/curl-#{@_ver}.tar.xz"
  source_sha256 'a132bd93188b938771135ac7c1f3ac1d3ce507c1fcbef8c471397639214ae2ab'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.80.0_armv7l/curl-7.80.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.80.0_armv7l/curl-7.80.0-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.80.0_i686/curl-7.80.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.80.0_x86_64/curl-7.80.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'aa54bf17aba4e15c170d84cd6b026a5547829d48c6e617193127f2ee15480a76',
     armv7l: 'aa54bf17aba4e15c170d84cd6b026a5547829d48c6e617193127f2ee15480a76',
    i686: '6214e778ae76f68af2c53b28323e4953e26bb6159cb21de941058ae1e9e8f43f',
  x86_64: 'f3369f552b866320577048242ea5c8fd591b9e323a0810bb5d4a388f6815f949'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'libunbound' => :build
  depends_on 'musl_brotli' => :build
  depends_on 'musl_c_ares' => :build
  depends_on 'musl_cyrus_sasl' => :build
  depends_on 'musl_krb5' => :build
  depends_on 'musl_libidn2' => :build
  depends_on 'musl_libnghttp2' => :build
  depends_on 'musl_libssh' => :build
  depends_on 'musl_libunistring' => :build
  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_ncurses' => :build
  depends_on 'musl_openssl' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_zstd' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build

  def self.patch
    # Curl 7.78.0 needs a patch to enable static builds.
    # See https://github.com/moparisthebest/static-curl/commit/0ab82474d449b7f2ea0d43451fd3951ebd49ddc3
    @curl_778_static_patch = <<~CURL_HEREDOC
            diff --git a/src/Makefile.am b/src/Makefile.am
            index 734373187..37e3a1564 100644
            --- a/src/Makefile.am
            +++ b/src/Makefile.am
            @@ -66,6 +66,9 @@ else
             curl_LDADD = \$(top_builddir)/lib/libcurl.la @NSS_LIBS@ @SSL_LIBS@ @ZLIB_LIBS@ @CURL_NETWORK_AND_TIME_LIBS@
             endif
      #{'       '}
            +curl_LDFLAGS = \$(curl_LDFLAGS)
            +curl_CPPFLAGS = \$(AM_CPPFLAGS)
            +
             # if unit tests are enabled, build a static library to link them with
             if BUILD_UNITTESTS
             noinst_LTLIBRARIES = libcurltool.la
    CURL_HEREDOC
    File.write('curl_778_static.patch', @curl_778_static_patch)
    system 'patch -Np1 -i curl_778_static.patch'
  end

  def self.build
    @abi = ''
    @arch_ssp_cflags = ''
    @arch_c_flags = ''
    @arch_cxx_flags = ''
    case ARCH
    when 'aarch64', 'armv7l'
      @abi = 'eabihf'
      @openssl_configure_target = 'linux-generic32'
    when 'i686'
      @arch_ssp_cflags = '-fno-stack-protector'
      @openssl_configure_target = 'linux-x86'
    when 'x86_64'
      @openssl_configure_target = 'linux-x86_64'
    end

    @cflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} #{@arch_ssp_cflags} -fcommon"
    @cxxflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} #{@arch_ssp_cflags} -fcommon"
    @ldflags = "-L#{CREW_PREFIX}/musl/lib -flto -static"
    @cmake_ldflags = '-flto'
    @curldep_cmake_options = "PATH=#{CREW_PREFIX}/musl/bin:#{CREW_PREFIX}/musl/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
          CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
          CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
          LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
          AR=#{CREW_PREFIX}/bin/ar \
          CFLAGS='#{@cflags}' \
          CXXFLAGS='#{@cxxflags}' \
          CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
          LDFLAGS='#{@cmake_ldflags}' \
          cmake \
          -DCMAKE_INSTALL_PREFIX='#{CREW_PREFIX}/musl' \
          -DCMAKE_INSTALL_LIBDIR='#{CREW_PREFIX}/musl/lib' \
          -DCMAKE_LIBRARY_PATH='#{CREW_PREFIX}/musl/lib' \
          -DCMAKE_C_COMPILER=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc \
          -DCMAKE_CXX_COMPILER=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++ \
          -DCMAKE_INCLUDE_DIRECTORIES_BEFORE=ON \
          -DINCLUDE_DIRECTORIES=#{CREW_PREFIX}/musl/include \
          -DCMAKE_C_FLAGS='#{@cflags}' \
          -DCMAKE_CXX_FLAGS='#{@cxxflags}' \
          -DCMAKE_EXE_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DCMAKE_SHARED_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DCMAKE_STATIC_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DCMAKE_MODULE_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DPROPERTY_INTERPROCEDURAL_OPTIMIZATION=TRUE \
          -DCMAKE_BUILD_TYPE=Release"

    @curldep_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{CREW_PREFIX}/musl/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB -fcommon' \
        LDFLAGS='#{@ldflags}'"

    @krb5_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        LIBS='-l:libncursesw.a -l:libtinfow.a' \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{CREW_PREFIX}/musl/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB -fcommon' \
        LDFLAGS=' #{@ldflags} -l:libncursesw.a -l:libtinfow.a'"

    @krb5_static_libs = "#{CREW_PREFIX}/musl/lib/libkrb5support.a  #{CREW_PREFIX}/musl/lib/libgssapi_krb5.a #{CREW_PREFIX}/musl/lib/libkrb5.a  #{CREW_PREFIX}/musl/lib/libk5crypto.a #{CREW_PREFIX}/musl/lib/libcom_err.a"

    @curl_lib_deps = "#{@krb5_static_libs} \
      -l:libresolv.a \
      -l:libm.a \
      -l:libbrotlicommon-static.a \
      -l:libbrotlidec-static.a \
      -l:libzstd.a \
      -l:libz.a \
      -l:libssl.a \
      -l:libcrypto.a \
      -l:libsasl2.a \
      -l:libnghttp2.a \
      -l:libpthread.a \
      -l:libncursesw.a \
      -l:libtinfow.a \
      -l:libcares.a \
      -l:libunistring.a \
      -l:libidn2.a \
      -l:libssh.a"

    @curl_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{CREW_PREFIX}/musl/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB' \
        LDFLAGS='#{@ldflags}'"

    system 'autoreconf -fvi'
    system 'filefix'
    system "PKG_CONFIG='pkg-config --static' \
    #{@curl_env_options} \
    LIBS='#{@curl_lib_deps} \
    -L#{CREW_PREFIX}/musl/lib' \
    CURL_LIBRARY_PATH=#{CREW_PREFIX}/musl/lib \
    ./configure --prefix=#{CREW_PREFIX}/musl \
    --libdir=#{CREW_PREFIX}/musl/lib \
    --disable-dependency-tracking \
    --disable-imap \
    --disable-ldap \
    --disable-ldaps \
    --disable-maintainer-mode \
    --disable-rtsp \
    --disable-shared \
    --enable-ares \
    --enable-ipv6 \
    --enable-static \
    --enable-unix-sockets \
    --with-brotli=#{CREW_PREFIX}/musl \
    --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
    --with-ca-fallback \
    --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
    --with-gssapi=#{CREW_PREFIX}/musl \
    --with-libidn2=#{CREW_PREFIX}/musl \
    --with-libssh=#{CREW_PREFIX}/musl \
    --with-nghttp2=#{CREW_PREFIX}/musl \
    --with-openssl=#{CREW_PREFIX}/musl \
    --without-librtmp \
    --with-zlib=#{CREW_PREFIX}/musl \
    "
    system "make curl_LDFLAGS='-static -all-static'"
    # FileUtils.cp 'src/curl', 'curl.static'
  end

  def self.check
    # Fail if curl is not statically built.
    system 'ldd src/curl && exit 1 || true'
    system 'src/curl -Lf https://github.com/skycocker/chromebrew/raw/master/install.sh -o /tmp/install.sh'
    FileUtils.rm '/tmp/install.sh'
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install', 'curl_LDFLAGS=-all-static'
    # Curl already includes man pages via "curl -M"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/musl/share/man"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    # Simplying the following block leads to the symlink not being created properly.
    Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
      FileUtils.ln_s '../musl/bin/curl', 'curl'
    end
    # FileUtils.install 'curl.static', "#{CREW_DEST_PREFIX}/bin/curl", mode: 0o755
  end
end
