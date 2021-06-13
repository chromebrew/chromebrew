require 'package'

class Git < Package
  description 'Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.'
  homepage 'https://git-scm.com/'
  @_ver = '2.32.0'
  version "#{@_ver}-musl-1"
  license 'GPL-2'
  compatibility 'all'
  source_url "https://github.com/git/git/archive/v#{@_ver}.tar.gz"
  source_sha256 '004697482b6e3b0ae9147580c32efd35869426227f1526f8eafa7950c31def94'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0-musl-1_armv7l/git-2.32.0-musl-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0-musl-1_armv7l/git-2.32.0-musl-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0-musl-1_i686/git-2.32.0-musl-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/git/2.32.0-musl-1_x86_64/git-2.32.0-musl-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f9dce49267eab2dd52233ff8bfdc6899f482dd17dc67a50eebbd2e531a2aa6b4',
     armv7l: 'f9dce49267eab2dd52233ff8bfdc6899f482dd17dc67a50eebbd2e531a2aa6b4',
       i686: '232ec85839ba8169cb5c503ffc668085c90611d98276ec3823b7d65cfd1e00b2',
     x86_64: '17eac279771387b441bd0175cd30451e5ac6f5cb2cd21f73f99477fadba5d947'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'hashpipe' => :build
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build

  @deppath = "#{`pwd`.chomp}/deproot"

  def self.build

    # Create a new buildroot just for musl.
    FileUtils.mkdir_p 'build'
    FileUtils.mkdir_p 'deproot/include'
    FileUtils.mkdir_p 'deproot/lib'
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

    @cflags = "-B#{@deppath}/include -flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} #{@arch_ssp_cflags} -fcommon"
    @cxxflags = "-B#{@deppath}/include -flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} #{@arch_ssp_cflags} -fcommon"
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

    FileUtils.mkdir_p 'build/zlib'
    Dir.chdir 'build/zlib' do
      puts 'Building Zlib.'.yellow
      system 'curl -Ls http://zlib.net/zlib-1.2.11.tar.gz | \
        hashpipe sha256 c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1 | \
        tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --static"
      system 'make'
      system 'make install'
    end

    FileUtils.mkdir_p 'build/unistring'
    Dir.chdir 'build/unistring' do
      puts 'Building Unistring.'.yellow
      system 'curl -Ls https://ftpmirror.gnu.org/libunistring/libunistring-0.9.10.tar.xz | \
        hashpipe sha256 eb8fb2c3e4b6e2d336608377050892b54c3c983b646c561836550863003c05d7 | \
        tar --strip-components=1 -Jxf -'
      system "#{@curldep_env_options} \
      ./configure --prefix=#{@deppath} \
        --enable-static \
        --disable-shared"
      system 'make'
      system 'make install'
    end

    FileUtils.mkdir_p 'build/ncurses'
    Dir.chdir 'build/ncurses' do
      puts 'Building Ncurses.'.yellow
      system 'curl -Ls https://api.github.com/repos/mirror/ncurses/tarball/2a969388725aa1ee321acadf09a4ff8e00787036 | \
        hashpipe sha256 662836416ec72d4af1d023769d4212b0cc0eb1d9b2442ebdc8af3e08f2f463c2 | \
        tar --strip-components=1 -zxf -'
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

    FileUtils.mkdir_p 'build/krb5'
    Dir.chdir 'build/krb5' do
      puts 'Building krb5.'.yellow
      @k5libs = %w[libgssapi_krb5.a libgssrpc.a libk5crypto.a
                   libkadm5clnt_mit.a libkadm5clnt.a libkadm5srv_mit.a libkadm5srv.a
                   libkdb5.a libkrad.a libkrb5.a libkrb5support.a libverto.a libcom_err.a]
      system 'curl -Ls "https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.1.tar.gz" | \
        hashpipe sha256 fa16f87eb7e3ec3586143c800d7eaff98b5e0dcdf0772af7d98612e49dbeb20b | \
        tar --strip-components=1 -zxf -'
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

    FileUtils.mkdir_p 'build/cyrus'
    Dir.chdir 'build/cyrus' do
      puts 'Building cyrussasl.'.yellow
      system 'curl -Ls https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz | \
        hashpipe sha256 26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5 | \
        tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --enable-static \
        --enable-shared \
        --with-cxx-static"
      system 'make'
      system 'make install'
    end

    FileUtils.mkdir_p 'build/zstd'
    Dir.chdir 'build/zstd' do
      puts 'Building Zstd.'.yellow
      system 'curl -Ls https://github.com/facebook/zstd/archive/v1.5.0.tar.gz | \
        hashpipe sha256 0d9ade222c64e912d6957b11c923e214e2e010a18f39bec102f572e693ba2867 | \
        tar --strip-components=1 -zxf -'
      FileUtils.mkdir('build/cmake/builddir')
      Dir.chdir('build/cmake/builddir') do
        system "#{@curldep_cmake_options} \
        -DZSTD_BUILD_STATIC=ON \
        -DZSTD_BUILD_SHARED=OFF \
        ../ -G Ninja"
      end
      system "PATH=#{@deppath}/bin:#{@deppath}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} ninja -C build/cmake/builddir -j#{CREW_NPROC}"
      system 'ninja -C build/cmake/builddir install'
    end

    FileUtils.mkdir_p 'build/brotli'
    Dir.chdir 'build/brotli' do
      puts 'Building Brotli.'.yellow
      system 'curl -Ls https://github.com/google/brotli/archive/v1.0.9.tar.gz | \
        hashpipe sha256 f9e8d81d0405ba66d181529af42a3354f838c939095ff99930da6aa9cdf6fe46 | \
        tar --strip-components=1 -zxf -'
      FileUtils.mkdir('builddir')
      Dir.chdir('builddir') do
        system "#{@curldep_cmake_options} \
          -DBUILD_SHARED_LIBS=OFF \
          -DWITH_STATIC_LIB=ON \
        ../ -G Ninja"
      end
      system "PATH=#{@deppath}/bin:#{@deppath}/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} ninja -C builddir -j#{CREW_NPROC}"
      system 'ninja -C builddir install'
      Dir.chdir "#{@deppath}/#{ARCH_LIB}" do
        @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
        @brotlilibs.each do |lib|
          FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
        end
      end
    end

    FileUtils.mkdir_p 'build/cares'
    Dir.chdir 'build/cares' do
      puts 'Building C-Ares.'.yellow
      system 'curl -Ls https://c-ares.haxx.se/download/c-ares-1.17.1.tar.gz | \
     hashpipe sha256 d73dd0f6de824afd407ce10750ea081af47eba52b8a6cb307d220131ad93fc40 | \
     tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath}"
      system 'make'
      system 'make install'
    end

    FileUtils.mkdir_p 'build/ssl'
    Dir.chdir 'build/ssl' do
      puts 'Building OpenSSL.'.yellow
      system 'curl -Ls https://www.openssl.org/source/openssl-1.1.1k.tar.gz | \
        hashpipe sha256 892a0875b9872acd04a9fde79b1f943075d5ea162415de3047c327df33fbaee5 | \
        tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} \
        ./Configure \
        --prefix=#{@deppath} \
        no-tests zlib no-shared \
        #{@openssl_configure_target}"
      system 'make'
      system 'make install_sw'
    end

    FileUtils.mkdir_p 'build/nghttp2'
    Dir.chdir 'build/nghttp2' do
      puts 'Building Nghttp2.'.yellow
      system 'curl -Ls https://github.com/nghttp2/nghttp2/releases/download/v1.43.0/nghttp2-1.43.0.tar.gz | \
        hashpipe sha256 45cc3ed91966551f92b31958ceca9b3a9f23ce4faf5cbedb78aa3327cd4e5907 | \
        tar --strip-components=1 -zxf -'
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
      -l:libcares.a"

    @curl_env_options = "PATH=#{@deppath}/bin:#{ENV['PATH']} \
        CC='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{@deppath}/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB' \
        LDFLAGS='#{@ldflags}'"

    FileUtils.mkdir_p 'build/curl'
    Dir.chdir 'build/curl' do
      puts 'Building libcurl.'.yellow
      system 'curl -Ls https://curl.se/download/curl-7.77.0.tar.xz | \
        hashpipe sha256 0f64582c54282f31c0de9f0a1a596b182776bd4df9a4c4a2a41bbeb54f62594b | \
        tar --strip-components=1 -Jxf -'
      system '[ -x configure ] || autoreconf -fvi'
      system 'filefix'
      system "#{@curl_env_options} \
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
      --with-nghttp2=#{@deppath} \
      --with-openssl=#{@deppath} \
      --with-brotli=#{@deppath} \
      --without-librtmp \
      --with-openssl=#{@deppath} \
      --with-zlib=#{@deppath}"
      system 'make curl_LDFLAGS=-all-static'
      system 'make install curl_LDFLAGS=-all-static'
      FileUtils.cp 'src/curl', "#{@deppath}/bin/curl_musl_static"
    end

    @curl_static_libs = `#{@deppath}/bin/curl-config --static-libs`.chomp.gsub('=auto', '')
    @git_libs = "#{@krb5_static_libs} \
        -l:libresolv.a \
        -l:libm.a \
        -l:libbrotlidec-static.a \
        -l:libbrotlicommon-static.a \
        -l:libzstd.a \
        -l:libssl.a \
        -l:libcrypto.a \
        -l:libz.a \
        -l:libsasl2.a \
        -l:libnghttp2.a \
        -l:libpthread.a \
        -l:libncursesw.a \
        -l:libtinfow.a \
        -l:libcurl.a \
        -l:libcares.a"
    @git_env_options = "PATH=#{@deppath}/bin:#{ENV['PATH']} \
        CC='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{@deppath}/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        LIBS='#{@git_libs}' \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{@deppath}/include -DCURL_STATICLIB -DNGHTTP2_STATICLIB -fcommon' \
        LDFLAGS='#{@ldflags} \
       #{@git_libs}'"

    FileUtils.mkdir 'curl'
    FileUtils.ln_s "#{@deppath}/include/curl", 'curl/include'
    FileUtils.ln_s "#{@deppath}/#{ARCH_LIB}", "curl/lib#{CREW_LIB_SUFFIX}"
    system 'autoreconf -fiv'
    system "#{@git_env_options} \
    ./configure \
      --prefix=#{CREW_PREFIX} \
      --libdir=#{CREW_LIB_PREFIX} \
      CURLDIR=`pwd`/curl \
      CURL_LDFLAGS='-L#{@deppath}/#{ARCH_LIB} #{@git_libs}' \
      --with-lib='lib#{CREW_LIB_SUFFIX}' \
      --with-openssl \
      --without-tcltk \
      --with-curl \
      --with-perl=#{CREW_PREFIX}/bin/perl \
      --with-python=#{CREW_PREFIX}/bin/python3 \
      --with-gitconfig=#{CREW_PREFIX}/etc/gitconfig \
      --with-gitattributes=#{CREW_PREFIX}/etc/gitattributes"
    system 'cp config.log /tmp'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # Save a copy of the built static curl. It's useful to have as a
    # backup. This also gives insight into the libcurl which has been
    # been compiled into git.
    FileUtils.cp "#{@deppath}/bin/curl_musl_static", "#{CREW_DEST_PREFIX}/bin/"
    Dir.chdir CREW_DEST_PREFIX do
      system 'symlinks -cr .'
    end
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/git-completion"
    FileUtils.cp_r Dir.glob('contrib/completion/.'), "#{CREW_DEST_PREFIX}/share/git-completion/"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @git_bashd_env = <<~GIT_BASHD_EOF
      # git bash completion
      source #{CREW_PREFIX}/share/git-completion/git-completion.bash
    GIT_BASHD_EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/git", @git_bashd_env)
  end

  def self.check
    # Check to see if linking libcurl worked, which means
    # git-remote-https should exist
    system "ls #{CREW_DEST_PREFIX}/libexec/git-core/git-remote-https"
  end
end
