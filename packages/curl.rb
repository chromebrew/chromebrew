require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.78.0'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url "https://github.com/curl/curl/releases/download/curl-#{@_ver.gsub('.', '_')}/curl-#{@_ver}.tar.xz"
  source_sha256 'be42766d5664a739c3974ee3dfbbcbe978a4ccb1fe628bb1d9b59ac79e445fb5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.78.0_armv7l/curl-7.78.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.78.0_armv7l/curl-7.78.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.78.0_x86_64/curl-7.78.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'df072e1766792584fa39d88998980daaa4f0dbfc5c5965f9b41648d9287baee8',
     armv7l: 'df072e1766792584fa39d88998980daaa4f0dbfc5c5965f9b41648d9287baee8',
     x86_64: '805fda203d132613cb0456ae33987985dd386278c46e3643a6e57620bb91d5b6'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'hashpipe' => :build
  depends_on 'libunbound' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build

  def self.prebuild
    FileUtils.mkdir_p 'deproot/include'
    FileUtils.mkdir_p 'deproot/lib'
    @builddirs = %w[zlib cyrus zstd brotli cares idn2 krb5 ssl unistring ncurses nghttp2]
    @builddirs.each do |builddir|
      FileUtils.mkdir_p "build/#{builddir}"
    end
    Dir.chdir 'deproot' do
      FileUtils.ln_s 'lib', 'lib64'
    end
    @deppath = "#{`pwd`.chomp}/deproot"
    # some linux headers need to be symlinked in.
    FileUtils.ln_s "#{CREW_PREFIX}/include/linux", "#{@deppath}/include/"
    FileUtils.ln_s "#{CREW_PREFIX}/include/asm", "#{@deppath}/include/"
    FileUtils.ln_s "#{CREW_PREFIX}/include/asm-generic", "#{@deppath}/include/"

    # Install musl-native compiler from musl.cc
    # The existing musl package only offers a gcc wrapper, which doesn't
    # work for c++ programs. We need a full musl runtime to be able to
    # build with musl. Luckily, this is easy.
    puts "Getting musl native compiler for #{ARCH}".lightblue
    Dir.chdir 'deproot' do
      case ARCH
      when 'i686'
        system 'curl -Ls https://musl.cc/i686-linux-musl-native.tgz | \
          hashpipe sha256 ae18b6d0fa58a638dba3b6efa1e660433fe9c0a0ef4283955dd934bc09a9898e | \
          tar --strip-components=1 -zxf -'
      when 'armv7l'
        system 'curl -Ls https://musl.cc/armv7l-linux-musleabihf-native.tgz | \
          hashpipe sha256 bf54a4762aed1a53be247bd5ead66569145c02d7ec78f405b184a7cda80149d1 | \
          tar --strip-components=1 -zxf -'
      when 'aarch64'
        system 'curl -Ls https://musl.cc/aarch64-linux-musl-native.tgz | \
          hashpipe sha256 dde5a762e59c7ef16680e7371b50734646eb4fcd7963f557ce0e65044e17e2e6 | \
          tar --strip-components=1 -zxf -'
      when 'x86_64'
        system 'curl -Ls https://musl.cc/x86_64-linux-musl-native.tgz | \
          hashpipe sha256 6bceb516e51d2eecc65e9670f605692fec419bb7ecca701bb021b720f71d6d86 | \
          tar --strip-components=1 -zxf -'
        FileUtils.ln_sf 'lib/ld.so', 'lib/ld-musl-x86_64.so.1'
      end
    end

    puts 'Downloading supporting libraries.'.yellow
    Dir.chdir 'build/zlib' do
      system 'curl -#L https://zlib.net/zlib-1.2.11.tar.gz | \
        hashpipe sha256 c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1 | \
        tar xz --strip-components=1'
    end
    Dir.chdir 'build/cyrus' do
      system 'curl -Ls https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz | \
        hashpipe sha256 26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5 | \
        tar --strip-components=1 -zxf -'
    end
    Dir.chdir 'build/zstd' do
      system 'curl -#L https://github.com/facebook/zstd/archive/v1.5.0.tar.gz | \
        hashpipe sha256 0d9ade222c64e912d6957b11c923e214e2e010a18f39bec102f572e693ba2867 | \
        tar xz --strip-components=1'
    end
    Dir.chdir 'build/brotli' do
      system 'curl -#L https://github.com/google/brotli/archive/v1.0.9.tar.gz | \
        hashpipe sha256 f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46 | \
        tar xz --strip-components=1'
    end
    Dir.chdir 'build/cares' do
      system 'curl -Ls https://c-ares.haxx.se/download/c-ares-1.17.2.tar.gz | \
     hashpipe sha256 4803c844ce20ce510ef0eb83f8ea41fa24ecaae9d280c468c582d2bb25b3913d | \
     tar --strip-components=1 -zxf -'
    end
    Dir.chdir 'build/idn2' do
      system 'curl -#L https://ftpmirror.gnu.org/libidn/libidn2-2.3.2.tar.gz | \
        hashpipe sha256 76940cd4e778e8093579a9d195b25fff5e936e9dc6242068528b437a76764f91 | \
        tar xz --strip-components=1'
    end
    Dir.chdir 'build/ssl' do
      system 'curl -#L https://www.openssl.org/source/openssl-1.1.1k.tar.gz | \
        hashpipe sha256 892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5 | \
        tar xz --strip-components=1'
    end
    Dir.chdir 'build/nghttp2' do
      system 'curl -#L https://github.com/nghttp2/nghttp2/releases/download/v1.44.0/nghttp2-1.44.0.tar.bz2 | \
        hashpipe sha256 989971276517a1c9ed330b779c34cf02d99da3b85d156eb297f42b1b7227b297 | \
        tar xj --strip-components=1'
    end
    Dir.chdir 'build/ncurses' do
      system 'curl -Ls https://api.github.com/repos/mirror/ncurses/tarball/2a969388725aa1ee321acadf09a4ff8e00787036 | \
        hashpipe sha256 662836416ec72d4af1d023769d4212b0cc0eb1d9b2442ebdc8af3e08f2f463c2 | \
        tar --strip-components=1 -zxf -'
    end
    Dir.chdir 'build/unistring' do
      system 'curl -Ls https://ftpmirror.gnu.org/libunistring/libunistring-0.9.10.tar.xz | \
        hashpipe sha256 eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7 | \
        tar --strip-components=1 -Jxf -'
    end
    Dir.chdir 'build/krb5' do
      system 'curl -Ls "https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.2.tar.gz" | \
        hashpipe sha256 10453fee4e3a8f8ce6129059e5c050b8a65dab1c257df68b99b3112eaa0cdf6a | \
        tar --strip-components=1 -zxf -'
    end
  end

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
    IO.write('curl_778_static.patch', @curl_778_static_patch)
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

    @cflags = "-B#{@deppath}/include -flto -pipe -Os -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} #{@arch_ssp_cflags} -fcommon"
    @cxxflags = "-B#{@deppath}/include -flto -pipe -Os -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} #{@arch_ssp_cflags} -fcommon"
    @ldflags = "-L#{@deppath}/#{ARCH_LIB} -flto -static"
    @cmake_ldflags = '-flto'
    @curldep_cmake_options = "PATH=#{@deppath}/bin:#{@deppath}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
          CC='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
          CXX='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++' \
          LD=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
          AR=#{CREW_PREFIX}/bin/ar \
          CFLAGS='#{@cflags}' \
          CXXFLAGS='#{@cxxflags}' \
          CPPFLAGS='-I#{@deppath}/include -fcommon' \
          LDFLAGS='#{@cmake_ldflags}' \
          cmake \
          -DCMAKE_INSTALL_PREFIX='#{@deppath}' \
          -DCMAKE_LIBRARY_PATH='#{@deppath}/#{ARCH_LIB}' \
          -DCMAKE_C_COMPILER=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc \
          -DCMAKE_CXX_COMPILER=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++ \
          -DCMAKE_INCLUDE_DIRECTORIES_BEFORE=ON \
          -DINCLUDE_DIRECTORIES=#{@deppath}/include \
          -DCMAKE_C_FLAGS='#{@cflags}' \
          -DCMAKE_CXX_FLAGS='#{@cxxflags}' \
          -DCMAKE_EXE_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DCMAKE_SHARED_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DCMAKE_STATIC_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DCMAKE_MODULE_LINKER_FLAGS='#{@cmake_ldflags}' \
          -DPROPERTY_INTERPROCEDURAL_OPTIMIZATION=TRUE \
          -DCMAKE_BUILD_TYPE=Release"

    @curldep_env_options = "PATH=#{@deppath}/bin:#{ENV['PATH']} \
        CC='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        PKG_CONFIG_LIBDIR=#{@deppath}/#{ARCH_LIB} \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{@deppath}/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB -fcommon' \
        LDFLAGS='#{@ldflags}'"

    @krb5_env_options = "PATH=#{@deppath}/bin:#{ENV['PATH']} \
        CC='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        LIBS='-l:libncursesw.a -l:libtinfow.a' \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{@deppath}/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB -fcommon' \
        LDFLAGS=' #{@ldflags} -l:libncursesw.a -l:libtinfow.a'"

    Dir.chdir 'build/zlib' do
      puts 'Building Zlib.'.yellow
      system 'filefix'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --static"
      system 'make'
      system 'make install'
    end

    Dir.chdir 'build/unistring' do
      puts 'Building Unistring.'.yellow
      system "#{@curldep_env_options} \
      ./configure --prefix=#{@deppath} \
        --enable-static \
        --disable-shared"
      system 'make'
      system 'make install'
    end

    Dir.chdir 'build/ncurses' do
      puts 'Building Ncurses.'.yellow
      system "#{@curldep_env_options} \
      ./configure --prefix=#{@deppath} \
        --with-static \
        --with-cxx-static \
        --without-debug \
        --enable-pc-files \
        --enable-widec \
        --without-tests \
        --with-termlib"
      system 'make'
      system 'make install'
    end

    Dir.chdir 'build/krb5' do
      puts 'Building krb5.'.yellow
      @k5libs = %w[libgssapi_krb5.a libgssrpc.a libk5crypto.a
                   libkadm5clnt_mit.a libkadm5clnt.a libkadm5srv_mit.a libkadm5srv.a
                   libkdb5.a libkrad.a libkrb5.a libkrb5support.a libverto.a libcom_err.a]
      Dir.chdir 'src' do
        # krb5 built with gcc10 or newer needs -fcommon
        # See https://github.com/ripple/rippled/pull/3813
        system "#{@krb5_env_options} \
        ./configure --prefix=#{@deppath} \
        --localstatedir=#{CREW_PREFIX}/var/krb5kdc \
        --disable-shared \
        --enable-static \
        --without-system-verto \
        --without-libedit \
        --disable-rpath \
        --without-keyutils"
        system 'make'
        system 'make install'
      end
    end

    Dir.chdir 'build/cyrus' do
      puts 'Building cyrussasl.'.yellow
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --enable-static \
        --enable-shared \
        --with-cxx-static"
      system 'make'
      system 'make install'
    end

    Dir.chdir 'build/zstd' do
      puts 'Building Zstd.'.yellow
      FileUtils.mkdir('build/cmake/builddir')
      Dir.chdir('build/cmake/builddir') do
        system "#{@curldep_cmake_options} \
        -DZSTD_BUILD_STATIC=ON \
        -DZSTD_BUILD_SHARED=OFF \
        ../ -G Ninja"
      end
      system "PATH=#{@deppath}/bin:#{@deppath}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} samu -C build/cmake/builddir -j#{CREW_NPROC}"
      system 'samu -C build/cmake/builddir install'
    end

    Dir.chdir 'build/brotli' do
      puts 'Building Brotli.'.yellow
      FileUtils.mkdir('builddir')
      Dir.chdir('builddir') do
        system "#{@curldep_cmake_options} \
          -DBUILD_SHARED_LIBS=OFF \
          -DWITH_STATIC_LIB=ON \
        ../ -G Ninja"
      end
      system "PATH=#{@deppath}/bin:#{@deppath}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} samu -C builddir -j#{CREW_NPROC}"
      system 'samu -C builddir install'
      Dir.chdir "#{@deppath}/#{ARCH_LIB}" do
        @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
        @brotlilibs.each do |lib|
          FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
        end
      end
    end

    Dir.chdir 'build/cares' do
      puts 'Building C-Ares.'.yellow
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath}"
      system 'make'
      system 'make install'
    end

    Dir.chdir 'build/idn2' do
      puts 'Building IDN2.'.yellow
      system 'filefix'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --disable-shared"
      system 'make'
      system 'make install'
    end

    Dir.chdir 'build/ssl' do
      puts 'Building OpenSSL.'.yellow
      system "#{@curldep_env_options} \
        ./Configure \
        --prefix=#{@deppath} \
        no-tests zlib no-shared \
        #{@openssl_configure_target}"
      system 'make'
      system 'make install_sw'
    end

    Dir.chdir 'build/nghttp2' do
      puts 'Building Nghttp2.'.yellow
      system 'filefix'
      system "#{@curldep_env_options} \
        LIBS='-l:libz.a \
        -l:libssl.a \
        -l:libcrypto.a \
        -l:libcares.a' \
        ./configure --prefix=#{@deppath} \
        --enable-lib-only \
        --disable-shared \
        --enable-static"
      system 'make'
      system 'make install'
    end

    puts 'Done building static curl dependencies.'.lightblue

    @krb5_static_libs = "#{@deppath}/#{ARCH_LIB}/libkrb5support.a #{@deppath}/#{ARCH_LIB}/libgssapi_krb5.a #{@deppath}/#{ARCH_LIB}/libkrb5.a #{@deppath}/#{ARCH_LIB}/libk5crypto.a #{@deppath}/#{ARCH_LIB}/libcom_err.a"

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
      -l:libidn2.a"

    @curl_env_options = "PATH=#{@deppath}/bin:#{ENV['PATH']} \
        CC='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{@deppath}/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB' \
        LDFLAGS='#{@ldflags}'"

    system 'autoreconf -fvi'
    system 'filefix'
    puts "#{@curl_env_options} \
    LIBS='#{@curl_lib_deps} \
    -L#{@deppath}/#{ARCH_LIB}' \
    CURL_LIBRARY_PATH=#{@deppath}/#{ARCH_LIB} \
    ./configure --prefix=#{@deppath} \
    --disable-imap \
    --disable-ldap \
    --disable-ldaps \
    --disable-maintainer-mode \
    --disable-dependency-tracking \
    --disable-rtsp \
    --disable-shared \
    --enable-ares \
    --enable-ipv6 \
    --enable-static \
    --enable-unix-sockets \
    --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
    --with-ca-fallback \
    --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
    --with-libidn2=#{@deppath} \
    --with-nghttp2=#{@deppath} \
    --with-openssl=#{@deppath} \
    --with-brotli=#{@deppath} \
    --without-librtmp \
    --with-openssl=#{@deppath} \
    --with-zlib=#{@deppath}"
    system "#{@curl_env_options} \
    LIBS='#{@curl_lib_deps} \
    -L#{@deppath}/#{ARCH_LIB}' \
    CURL_LIBRARY_PATH=#{@deppath}/#{ARCH_LIB} \
    ./configure --prefix=#{CREW_PREFIX} \
    --libdir=#{CREW_LIB_PREFIX} \
    --disable-imap \
    --disable-ldap \
    --disable-ldaps \
    --disable-libcurl-option \
    --disable-maintainer-mode \
    --disable-dependency-tracking \
    --disable-rtsp \
    --disable-shared \
    --enable-ares \
    --enable-ipv6 \
    --enable-static \
    --enable-unix-sockets \
    --with-ca-bundle=#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt \
    --with-ca-fallback \
    --with-ca-path=#{CREW_PREFIX}/etc/ssl/certs \
    --with-libidn2=#{@deppath} \
    --with-nghttp2=#{@deppath} \
    --with-openssl=#{@deppath} \
    --with-brotli=#{@deppath} \
    --without-librtmp \
    --with-openssl=#{@deppath} \
    --with-zlib=#{@deppath}"
    system 'make curl_LDFLAGS=-all-static'
    # system 'make install curl_LDFLAGS=-all-static'
    FileUtils.cp 'src/curl', 'curl.static'
  end

  def self.check
    # Fail if curl is not statically built.
    system 'ldd src/curl && exit 1 || true'
    system 'src/curl -Lf https://github.com/skycocker/chromebrew/raw/master/install.sh -o /tmp/install.sh'
    FileUtils.rm '/tmp/install.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'curl.static', "#{CREW_DEST_PREFIX}/bin/curl", mode: 0o755
  end
end
