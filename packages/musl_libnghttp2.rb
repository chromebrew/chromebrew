require 'package'

class Musl_libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  @_ver = '1.45.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.45.1_armv7l/musl_libnghttp2-1.45.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.45.1_armv7l/musl_libnghttp2-1.45.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.45.1_i686/musl_libnghttp2-1.45.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libnghttp2/1.45.1_x86_64/musl_libnghttp2-1.45.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '11da4116f1a2053d66dffc6ba678add182ce4fd779164a98206ccb2dac9c882b',
     armv7l: '11da4116f1a2053d66dffc6ba678add182ce4fd779164a98206ccb2dac9c882b',
       i686: '6976dfd15fbb3fe701d5805dd5fe5c9e3e8451a1fc4e3a3ffedd552484232260',
     x86_64: '89f12cc2a150334b932ecc58e235721d776e42dc44e9acd34fa4b0d5529dc8a3'
  })

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
      -DENABLE_SHARED_LIB=OFF \
      -DENABLE_STATIC_LIB=ON \
      -DENABLE_LIB_ONLY=ON \
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
