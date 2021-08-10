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
    aarch64: 'd17b29109e29ead28138ca614b118574414dde2cb4b71e4a608e42441b85d3ed',
     armv7l: 'd17b29109e29ead28138ca614b118574414dde2cb4b71e4a608e42441b85d3ed',
     x86_64: 'ef555c818ee539f884e19801d868168761b4de4af1849c9d0ce47091f3ca31bc'
  })

  depends_on 'ca_certificates' => :build
  depends_on 'hashpipe' => :build
  depends_on 'libunbound' => :build
  depends_on 'musl' => :build
  depends_on 'rust' => :build
  depends_on 'valgrind' => :build

  def self.prebuild
    FileUtils.mkdir_p 'deproot/include'
    FileUtils.mkdir_p 'deproot/lib'
    @builddirs = %w[zlib zstd brotli idn2 ssl libssh nghttp2]
    @builddirs.each do |builddir|
      FileUtils.mkdir_p "build/#{builddir}"
    end

    puts 'Downloading supporting libraries.'.yellow
    Dir.chdir 'build/zlib' do
      system 'curl -#L https://zlib.net/zlib-1.2.11.tar.gz | \
        hashpipe sha256 c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1 | \
        tar xz --strip-components=1'
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
    Dir.chdir 'build/libssh' do
      system 'curl -#L https://www.libssh.org/files/0.9/libssh-0.9.5.tar.xz | \
       hashpipe sha256 acffef2da98e761fc1fd9c4fddde0f3af60ab44c4f5af05cd1b2d60a3fa08718 | \
        tar xJ --strip-components=1'
    end
    Dir.chdir 'build/nghttp2' do
      system 'curl -#L https://github.com/nghttp2/nghttp2/releases/download/v1.44.0/nghttp2-1.44.0.tar.bz2 | \
        hashpipe sha256 989971276517a1c9ed330b779c34cf02d99da3b85d156eb297f42b1b7227b297 | \
        tar xj --strip-components=1'
    end
  end

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

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
          CFLAGS='-flto -pipe -Os -fPIC -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
          CXXFLAGS='-flto -pipe -Os -fPIC -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
          CPPFLAGS='-I#{@deppath}/include' \
          LDFLAGS='-L#{@deppath}/#{ARCH_LIB}' \
          cmake \
          -DCMAKE_INSTALL_PREFIX='#{@deppath}' \
          -DCMAKE_LIBRARY_PATH='#{@deppath}/#{ARCH_LIB}' \
          -DCMAKE_C_COMPILER=`which musl-gcc` \
          -DCMAKE_INCLUDE_DIRECTORIES_BEFORE=ON \
          -DINCLUDE_DIRECTORIES=#{@deppath}/include \
          -DCMAKE_C_FLAGS='-Os -fPIC -pipe -flto -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
          -DCMAKE_EXE_LINKER_FLAGS='-flto' \
          -DCMAKE_SHARED_LINKER_FLAGS='-flto' \
          -DCMAKE_STATIC_LINKER_FLAGS='-flto' \
          -DCMAKE_MODULE_LINKER_FLAGS='-flto' \
          -DPROPERTY_INTERPROCEDURAL_OPTIMIZATION=TRUE \
          -DCMAKE_BUILD_TYPE=Release"

    @curldep_env_options = "CC=musl-gcc \
        CFLAGS='-flto -pipe -Os -fPIC -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
        CXXFLAGS='-flto -pipe -Os -fPIC -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans#{@arch_ssp_cflags}' \
        CPPFLAGS='-I#{@deppath}/include' \
        LDFLAGS='-L#{@deppath}/#{ARCH_LIB}'"

    Dir.chdir 'build/zlib' do
      puts 'Building Zlib.'.yellow
      system 'filefix'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --static"
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
      system 'samu -C build/cmake/builddir'
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
      system 'samu -C builddir'
      system 'samu -C builddir install'
      Dir.chdir "#{@deppath}/#{ARCH_LIB}" do
        @brotlilibs = %w[libbrotlidec libbrotlienc libbrotlicommon]
        @brotlilibs.each do |lib|
          FileUtils.ln_s "#{lib}-static.a", "#{lib}.a"
        end
      end
    end

    Dir.chdir 'build/idn2' do
      puts 'Building IDN2.'.yellow
      system 'filefix'
      system "#{@curldep_env_options} ./configure --prefix=#{@deppath} \
        --disable-shared"
      system 'make'
      system 'make install'
    end

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
      puts 'Building OpenSSL.'.yellow
      system "CC=musl-gcc \
        CFLAGS='-flto -pipe -Os -fuse-ld=gold -fPIC #{@arch_c_flags} -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
        CXXFLAGS='-flto -pipe -Os -fuse-ld=gold -fPIC #{@arch_cxx_flags} -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
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
    # Dir.chdir 'build/libssh' do
    # puts 'Building Libssh.'.yellow
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
    # system 'samu -C builddir'
    # system 'samu -C builddir install'
    # end

    Dir.chdir 'build/nghttp2' do
      puts 'Building Nghttp2.'.yellow
      system 'filefix'
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
      CFLAGS='-flto -pipe -Os -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
      CXXFLAGS='-flto -pipe -Os -fuse-ld=gold -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_ssp_cflags}' \
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
