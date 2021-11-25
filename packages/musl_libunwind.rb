require 'package'

class Musl_libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  @_ver = '1.5.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.5.0.tar.gz'
  source_sha256 '90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1efb1017'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_armv7l/musl_libunwind-1.5.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_armv7l/musl_libunwind-1.5.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_i686/musl_libunwind-1.5.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_libunwind/1.5.0_x86_64/musl_libunwind-1.5.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8325ff524aa0259dfd76a96fe43a12d16f8cc7e7c0d1a69f2db5bd68eb0f5879',
     armv7l: '8325ff524aa0259dfd76a96fe43a12d16f8cc7e7c0d1a69f2db5bd68eb0f5879',
       i686: 'c87940a7e9ea4963fce675445c4276cf8baae2506fb4260adbb1b8baf78cc9d2',
     x86_64: '77172a1ee1ee561db6c95c1dffd8553b094214afbd8860a5dcdf00b0d288ec23'
  })

  depends_on 'musl_native_toolchain' => :build
  depends_on 'musl_libbacktrace' => :build
  depends_on 'musl_libucontext' => :build

  @abi = ''
  @arch_c_flags = ''
  @arch_cxx_flags = ''
  case ARCH
  when 'aarch64', 'armv7l'
    @abi = 'eabihf'
    @arch = 'arm'
  when 'i686'
    @arch = 'x86'
  when 'x86_64'
    @arch = 'x86_64'
  end

  @cflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_c_flags} -fcommon"
  @cxxflags = "-B#{CREW_PREFIX}/musl/include -flto -pipe -O3 -ffat-lto-objects -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans #{@arch_cxx_flags} -fcommon -static"
  @ldflags = "-L#{CREW_PREFIX}/musl/lib -flto -static"
  @cmake_ldflags = '-flto'

  @musldep_env_options = "PATH=#{CREW_PREFIX}/musl/bin:#{ENV['PATH']} \
      LIBRARY_PATH='#{CREW_PREFIX}/musl/lib:$LIBRARY_PATH' \
      CC='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-gcc' \
      CXX='#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-g++' \
      LD=#{CREW_PREFIX}/musl/bin/#{ARCH}-linux-musl#{@abi}-ld.gold \
      LIBDIR=#{CREW_PREFIX}/musl/lib \
      INCLUDEDIR=#{CREW_PREFIX}/musl/include \
      PKG_CONFIG_LIBDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      PKGCONFIGDIR=#{CREW_PREFIX}/musl/lib/pkgconfig \
      CFLAGS='#{@cflags}' \
      CXXFLAGS='#{@cxxflags}' \
      CPPFLAGS='-I#{CREW_PREFIX}/musl/include -fcommon' \
      LDFLAGS='#{@ldflags}'"

  def self.patch
    # As per https://www.linuxquestions.org/questions/linux-software-2/building-libunwind-on-x86-musl-libc-against-libucontext-4175692781/#post6235105
    # https://archive.md/gaEbN
    system "sed -i '1i#include <ucontext.h>\' src/#{@arch}/Gos-linux.c"
    system 'filefix'
  end

  def self.build
    system "#{@musldep_env_options} ./configure --prefix=#{CREW_PREFIX}/musl \
      --enable-shared \
      --enable-static \
      --enable-ptrace \
      --disable-tests"
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
