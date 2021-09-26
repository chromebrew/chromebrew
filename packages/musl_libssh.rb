require 'package'

class Musl_libssh < Package
  description 'libssh is a multiplatform C library implementing the SSHv2 and SSHv1 protocol on client and server side.'
  homepage 'https://www.libssh.org/'
  @_ver = '0.9.6'
  version @_ver
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.libssh.org/files/#{@_ver_prelastdot}/libssh-#{@_ver}.tar.xz"
  source_sha256 '86bcf885bd9b80466fe0e05453c58b877df61afa8ba947a58c356d7f0fab829b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libssh/0.9.6_armv7l/musl_libssh-0.9.6-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libssh/0.9.6_armv7l/musl_libssh-0.9.6-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libssh/0.9.6_i686/musl_libssh-0.9.6-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libssh/0.9.6_x86_64/musl_libssh-0.9.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'feb3f6d6dd7ce33d3c75e23229219c16488b1ea33e42b22737a24dcc875f69d8',
     armv7l: 'feb3f6d6dd7ce33d3c75e23229219c16488b1ea33e42b22737a24dcc875f69d8',
       i686: '9e617fa3711f49bae34b11fd98d7e4b90c347c76f0b504a31d65bbb1b7e2e194',
     x86_64: '1917dffdc56af43aea4ccd9472ea8d6d4002b3057ea1118907e20e6fdc383f50'
  })

  depends_on 'musl_krb5' => :build
  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_zlib' => :build
  depends_on 'musl_openssl' => :build

  @abi = ''
  @arch_ssp_cflags = ''
  @arch_c_flags = ''
  @arch_cxx_flags = ''
  case ARCH
  when 'aarch64', 'armv7l'
    @abi = 'eabihf'
  when 'i686'
    @arch_ssp_cflags = '-fno-stack-protector'
  when 'x86_64'
  end

  @cflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} #{@arch_ssp_cflags} -fcommon"
  @cxxflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} #{@arch_ssp_cflags} -fcommon"
  @ldflags = "-L#{CREW_PREFIX}/musl/lib -flto -static"
  @cmake_ldflags = '-flto'
  @musldep_cmake_options = "PATH=#{CREW_PREFIX}/musl/bin:#{CREW_PREFIX}/musl/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        AR=#{CREW_PREFIX}/musl/bin/ar \
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

  @musldep_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
      CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
      CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
      LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
      PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      CFLAGS='#{@cflags}' \
      CXXFLAGS='#{@cxxflags}' \
      CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
      LDFLAGS='#{@ldflags}'"

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "#{@musldep_cmake_options} \
      -DOPENSSL_INCLUDE_DIR=#{CREW_PREFIX}/musl/include \
      -DBUILD_SHARED_LIBS=OFF \
      -DGLOBAL_BIND_CONFIG=#{CREW_PREFIX}/etc/ssh/libssh_server_config \
      -DGLOBAL_CLIENT_CONFIG=#{CREW_PREFIX}/etc/ssh/ssh_config \
      -DHAVE_GLOB=0 \
      -DUNIT_TESTING=OFF \
      -DWITH_EXAMPLES=OFF \
      -DWITH_STATIC_LIB=ON \
      ../ -G Ninja"
    end
    system "PATH=#{CREW_PREFIX}/musl/bin:#{CREW_PREFIX}/musl/#{ARCH}-linux-musl#{@abi}/bin:#{ENV['PATH']} \
      samu -C builddir -j#{CREW_NPROC}"
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
