require 'package'

class Curl < Package
  description 'Command line tool and library for transferring data with URLs.'
  homepage 'https://curl.se/'
  @_ver = '7.77.0-git'
  version @_ver
  license 'curl'
  compatibility 'all'
  source_url 'https://github.com/curl/curl.git'
  git_hashtag 'curl-7_77_0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0-git_armv7l/curl-7.77.0-git-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0-git_armv7l/curl-7.77.0-git-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0-git_i686/curl-7.77.0-git-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/curl/7.77.0-git_x86_64/curl-7.77.0-git-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '45597919122d848c3b6b91358b67ade0eaa9fb9bfb887f97c6bdeee55fcc84c2',
     armv7l: '45597919122d848c3b6b91358b67ade0eaa9fb9bfb887f97c6bdeee55fcc84c2',
       i686: '02436eb8f258cd050cb7c3836801a16cb3c2f24a011ece6a4f388715b2d3c4a7',
     x86_64: '7399d70a022d09a421b461454b20528d5a8d4fd1976a8364b32190887e8a5780'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'libcurl' # L (This is only here to make sure upgrades of curl pull in libcurl.)
  depends_on 'libunbound' => :build
  depends_on 'musl' => :build
  depends_on 'py3_pip' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    @krb5_static_libs = '-l:libkrb5support.a -l:libgssapi_krb5.a -l:libkrb5.a -l:libk5crypto.a -l:libcom_err.a'

    FileUtils.mkdir_p 'build'
    FileUtils.mkdir_p 'deproot/include'
    FileUtils.mkdir_p 'deproot/lib'
    Dir.chdir 'deproot' do
      FileUtils.ln_s 'lib', 'lib64'
    end
    @deppath = "#{`pwd`.chomp}/deproot"
    FileUtils.ln_s "#{CREW_PREFIX}/include/linux", "#{@deppath}/include/"
    FileUtils.ln_s "#{CREW_PREFIX}/include/asm", "#{@deppath}/include/"
    FileUtils.ln_s "#{CREW_PREFIX}/include/asm-generic", "#{@deppath}/include/"

    @arch_ssp_cflags = ''
    case ARCH
    when 'i686'
      @arch_ssp_cflags = '-fno-stack-protector'
    end

    @curldep_cmake_options = "CC=musl-gcc \
          CFLAGS='-flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
          CXXFLAGS='-flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
          CPPFLAGS='-I#{@deppath}/include' \
          LDFLAGS='-L#{@deppath}/#{ARCH_LIB}' \
          cmake \
          -DCMAKE_INSTALL_PREFIX='#{@deppath}' \
          -DCMAKE_LIBRARY_PATH='#{@deppath}/#{ARCH_LIB}' \
          -DCMAKE_C_COMPILER=`which musl-gcc` \
          -DCMAKE_INCLUDE_DIRECTORIES_BEFORE=ON \
          -DINCLUDE_DIRECTORIES=#{@deppath}/include \
          -DCMAKE_C_FLAGS='-O3 -fPIC -pipe -flto -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
          -DCMAKE_EXE_LINKER_FLAGS='-flto' \
          -DCMAKE_SHARED_LINKER_FLAGS='-flto' \
          -DCMAKE_STATIC_LINKER_FLAGS='-flto' \
          -DCMAKE_MODULE_LINKER_FLAGS='-flto' \
          -DPROPERTY_INTERPROCEDURAL_OPTIMIZATION=TRUE \
          -DCMAKE_BUILD_TYPE=Release"

    @curldep_env_options = "CC=musl-gcc \
        CFLAGS='-flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
        CXXFLAGS='-flto -pipe -O3 -fPIC -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans#{@arch_ssp_cflags}' \
        CPPFLAGS='-I#{@deppath}/include' \
        LDFLAGS='-L#{@deppath}/#{ARCH_LIB}'"

    FileUtils.mkdir_p 'build/zlib'
    Dir.chdir 'build/zlib' do
      puts 'Building Zlib.'.lightgreen
      system 'curl -Ls http://zlib.net/zlib-1.2.11.tar.gz | tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --static"
      system 'make'
      system 'make install'
    end
    FileUtils.mkdir_p 'build/zstd'
    Dir.chdir 'build/zstd' do
      puts 'Building Zstd.'.lightgreen
      system 'curl -Ls https://github.com/facebook/zstd/archive/v1.5.0.tar.gz | tar --strip-components=1 -zxf -'
      FileUtils.mkdir('build/cmake/builddir')
      Dir.chdir('build/cmake/builddir') do
        system "#{@curldep_cmake_options} \
        -DZSTD_BUILD_STATIC=ON \
        -DZSTD_BUILD_SHARED=OFF \
        ../ -G Ninja"
      end
      system 'ninja -C build/cmake/builddir'
      system 'ninja -C build/cmake/builddir install'
    end
    FileUtils.mkdir_p 'build/brotli'
    Dir.chdir 'build/brotli' do
      puts 'Building Brotli.'.lightgreen
      system 'curl -Ls https://github.com/google/brotli/archive/v1.0.9.tar.gz | tar --strip-components=1 -zxf -'
      FileUtils.mkdir('builddir')
      Dir.chdir('builddir') do
        system "#{@curldep_cmake_options} \
          -DBUILD_SHARED_LIBS=OFF \
          -DWITH_STATIC_LIB=ON \
        ../ -G Ninja"
      end
      system 'ninja -C builddir'
      system 'ninja -C builddir install'
      Dir.chdir "#{@deppath}/#{ARCH_LIB}" do
        @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
        @brotlilibs.each do |lib|
          FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
        end
      end
    end
    FileUtils.mkdir_p 'build/idn2'
    Dir.chdir 'build/idn2' do
      puts 'Building IDN2.'.lightgreen
      system 'curl -Ls http://ftp.gnu.org/gnu/libidn/libidn2-2.3.1.tar.gz | tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --disable-shared"
      system 'make'
      system 'make install'
    end
    FileUtils.mkdir_p 'build/ssl'
    case ARCH
    when 'aarch64', 'armv7l'
      @arch_c_flags = '-march=armv7-a -mfloat-abi=hard'
      @arch_cxx_flags = '-march=armv7-a -mfloat-abi=hard'
      @openssl_configure_target = 'linux-generic32'
    when 'i686'
      @arch_c_flags = ''
      @arch_cxx_flags = ''
      @openssl_configure_target = 'linux-x86'
    when 'x86_64'
      @arch_c_flags = ''
      @arch_cxx_flags = ''
      @openssl_configure_target = 'linux-x86_64'
    end
    Dir.chdir 'build/ssl' do
      puts 'Building OpenSSL.'.lightgreen
      system 'curl -Ls https://www.openssl.org/source/openssl-1.1.1k.tar.gz | tar --strip-components=1 -zxf -'
      system "CC=musl-gcc \
        CFLAGS='-flto -pipe -O3 -fPIC #{@arch_c_flags} -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
        CXXFLAGS='-flto -pipe -O3 -fPIC #{@arch_cxx_flags} -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
        CPPFLAGS='-I#{@deppath}/include' \
        LDFLAGS='-L#{@deppath}/#{ARCH_LIB} -flto' \
        ./Configure \
        --prefix=#{@deppath} \
        no-tests zlib no-shared \
        #{@openssl_configure_target}"
      system 'make'
      system 'make install_sw'
    end

    # libssh has problems linking with musl statically
    # FileUtils.mkdir_p 'build/libssh'
    # Dir.chdir 'build/libssh' do
    # puts 'Building Libssh.'.lightgreen
    # system 'curl -Ls https://www.libssh.org/files/0.9/libssh-0.9.5.tar.xz | tar --strip-components=1 -Jxf -'
    # FileUtils.mkdir('builddir')
    # Dir.chdir('builddir') do
    # system "#{@curldep_cmake_options} \
    #-DWITH_EXAMPLES=OFF \
    #-DBUILD_SHARED_LIBS=OFF \
    #-DWITH_STATIC_LIB=ON \
    #-DWITH_GSSAPI=OFF \
    #-DHAVE_GLOB=0 \
    # ../ -G Ninja"
    # end
    # system 'ninja -C builddir'
    # system 'ninja -C builddir install'
    # end
    FileUtils.mkdir_p 'build/nghttp2'
    Dir.chdir 'build/nghttp2' do
      puts 'Building Nghttp2.'.lightgreen
      system 'curl -Ls https://github.com/nghttp2/nghttp2/releases/download/v1.43.0/nghttp2-1.43.0.tar.gz | tar --strip-components=1 -zxf -'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --enable-lib-only \
        --disable-shared \
        --enable-static"
      system 'make'
      system 'make install'
    end

    puts 'Done building static curl dependencies.'.lightgreen
    system '[ -x configure ] || autoreconf -fvi'
    system 'filefix'
    system "env CC=musl-gcc \
      PKG_CONFIG='pkg-config --static' \
      CPPFLAGS='-I#{@deppath}/include' \
      CFLAGS='-flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
      CXXFLAGS='-flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
      LDFLAGS='-L#{@deppath}/#{ARCH_LIB} -flto -static -Wl,--no-as-needed -ldl' \
      LIBS='#{@deppath}/#{ARCH_LIB}/libssl.a #{@deppath}/#{ARCH_LIB}/libcrypto.a #{@deppath}/#{ARCH_LIB}/libbrotlicommon.a #{@deppath}/#{ARCH_LIB}/libbrotlidec.a #{@deppath}/#{ARCH_LIB}/libidn2.a #{@deppath}/#{ARCH_LIB}/libnghttp2.a  #{@deppath}/#{ARCH_LIB}/libz.a #{@deppath}/#{ARCH_LIB}/libzstd.a -L#{@deppath}/#{ARCH_LIB}' \
      CURL_LIBRARY_PATH=#{@deppath}/#{ARCH_LIB} \
      ./configure --prefix=#{@deppath} \
      --disable-imap \
      --disable-ldap \
      --disable-ldaps \
      --disable-libcurl-option \
      --disable-maintainer-mode \
      --disable-rtsp \
      --disable-shared \
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
    FileUtils.cp 'src/curl', 'curl.static'
  end

  def self.check
    system 'src/curl -Lf https://github.com/skycocker/chromebrew/raw/master/install.sh -o /tmp/install.sh'
    FileUtils.rm '/tmp/install.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'curl.static', "#{CREW_DEST_PREFIX}/bin/curl", mode: 0o755
  end
end
