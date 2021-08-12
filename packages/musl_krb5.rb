require 'package'

class Musl_krb5 < Package
  description 'Kerberos is a network authentication protocol.'
  homepage 'https://web.mit.edu/kerberos'
  version '1.19.2'
  license 'openafs-krb5-a, BSD, MIT, OPENLDAP, BSD-2, HPND, BSD-4, ISC, RSA, CC-BY-SA-3.0 and BSD-2 or GPL-2+ )'
  compatibility 'all'
  source_url 'https://web.mit.edu/kerberos/dist/krb5/1.19/krb5-1.19.2.tar.gz'
  source_sha256 '10453fee4e3a8f8ce6129059e5c050b8a65dab1c257df68b99b3112eaa0cdf6a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.19.2_armv7l/musl_krb5-1.19.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.19.2_armv7l/musl_krb5-1.19.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.19.2_i686/musl_krb5-1.19.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_krb5/1.19.2_x86_64/musl_krb5-1.19.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '447399f2631634a0c8f5e296748c5d3ffc2e2951a5f63f7269e1490704e7b08c',
     armv7l: '447399f2631634a0c8f5e296748c5d3ffc2e2951a5f63f7269e1490704e7b08c',
       i686: 'ecf85191be363ccbb8c9d776306f1afdc673709d17a976180f473e4082a00a2a',
     x86_64: 'f2fbc0f85778d69a379eba8cb372ac9c38a00834a3690fb946c3e8bc2f780499'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_ncurses' => :build

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

  @krb5_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
        CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
        CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
        LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
        PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
        LIBS='-l:libncursesw.a -l:libtinfow.a' \
        CFLAGS='#{@cflags}' \
        CXXFLAGS='#{@cxxflags}' \
        CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
        LDFLAGS=' #{@ldflags} -l:libncursesw.a -l:libtinfow.a'"

  def self.build
    Dir.chdir 'src' do
      system "#{@krb5_env_options} ./configure --prefix=#{CREW_PREFIX}/musl \
          --localstatedir=#{CREW_PREFIX}/var/krb5kdc \
          --disable-shared \
          --enable-static \
          --without-system-verto \
          --without-libedit \
          --disable-rpath \
          --without-keyutils"
      system 'make'
    end
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    Dir.chdir 'src' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
