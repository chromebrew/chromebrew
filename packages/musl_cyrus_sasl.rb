require 'package'

class Musl_cyrus_sasl < Package
  description 'Simple Authentication and Security Layer (SASL) is a specification that describes how authentication mechanisms can be plugged into an application protocol on the wire. Cyrus SASL is an implementation of SASL that makes it easy for application developers to integrate authentication mechanisms into their application in a generic way.'
  homepage 'https://www.cyrusimap.org/sasl'
  version '2.1.27'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/cyrusimap/cyrus-sasl/releases/download/cyrus-sasl-2.1.27/cyrus-sasl-2.1.27.tar.gz'
  source_sha256 '26866b1549b00ffd020f188a43c258017fa1c382b3ddadd8201536f72efb05d5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cyrus_sasl/2.1.27_armv7l/musl_cyrus_sasl-2.1.27-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cyrus_sasl/2.1.27_armv7l/musl_cyrus_sasl-2.1.27-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cyrus_sasl/2.1.27_i686/musl_cyrus_sasl-2.1.27-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cyrus_sasl/2.1.27_x86_64/musl_cyrus_sasl-2.1.27-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a1f6ff66ce747000afdec8006730e87506c3e3c2a8af317816ad84fd240e97b8',
     armv7l: 'a1f6ff66ce747000afdec8006730e87506c3e3c2a8af317816ad84fd240e97b8',
       i686: '420b9dfd517bd981837a7e26d379d5996635dfc66eae1a02eae1d9ed8e6886aa',
     x86_64: 'c9c1e6ec2b43a3e3ad74dea27c310331ea6d209adb3bbf73429ff33d97950737'
  })

  depends_on 'musl_native_toolchain' => :build

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
    system "#{@musldep_env_options} ./configure --prefix=#{CREW_PREFIX}/musl \
        --enable-static \
        --with-cxx-static"
    system 'make'
  end

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
