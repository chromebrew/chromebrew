require 'package'

class Lld < Package
  description 'lld is a drop in replacement for the system linker that runs much faster.'
  homepage 'https://lld.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/lld-11.1.0.src.tar.xz'
  source_sha256 '017a788cbe1ecc4a949abf10755870519086d058a2e99f438829aef24f0c66ce'

  depends_on 'ncurses'
  depends_on 'llvm'
  depends_on 'cmake' => :build
  depends_on 'perl' => :build
  depends_on 'pkgconfig' => :build
  depends_on 'binutils' => :build
  depends_on 'linuxheaders' => :build
  depends_on 'python3' => :build

  case ARCH
  when 'aarch64', 'armv7l'
    # LLVM_TARGETS_TO_BUILD = 'ARM;AArch64;AMDGPU'
    LLVM_TARGETS_TO_BUILD = 'all'.freeze
    @ARCH_C_FLAGS = "-fPIC  -pipe -march=armv7-a -mfloat-abi=hard -ccc-gcc-name #{CREW_TGT}"
    @ARCH_CXX_FLAGS = "-fPIC -pipe -march=armv7-a -mfloat-abi=hard -ccc-gcc-name #{CREW_TGT}"
    @ARCH_LDFLAGS = ''
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=auto"
  when 'i686'
    LLVM_TARGETS_TO_BUILD = 'X86'.freeze
    # Because ld.lld: error: undefined symbol: __atomic_store
    # Polly demands fPIC
    @ARCH_C_FLAGS = '-latomic -fPIC -pipe'
    @ARCH_CXX_FLAGS = '-latomic -fPIC -pipe'
    # Because getting this error:
    # ld.lld: error: relocation R_386_PC32 cannot be used against symbol isl_map_fix_si; recompile with -fPIC
    # So as per https://github.com/openssl/openssl/issues/11305#issuecomment-602003528
    @ARCH_LDFLAGS = '-Wl,-znotext'
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=auto"
  when 'x86_64'
    # LLVM_TARGETS_TO_BUILD = 'X86;AMDGPU'
    LLVM_TARGETS_TO_BUILD = 'all'.freeze
    @ARCH_C_FLAGS = '-fPIC -pipe'
    @ARCH_CXX_FLAGS = '-fPIC -pipe'
    @ARCH_LDFLAGS = ''
    @ARCH_LTO_LDFLAGS = "#{@ARCH_LDFLAGS} -flto=auto"
  end
  @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -flto=auto"
  @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -flto=auto"

  @LLVM_CMAKE_OPTIONS = "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                      -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
                      -DCMAKE_BUILD_TYPE=Release \
                      -DLLVM_ENABLE_LTO=On \
                      -DCMAKE_C_COMPILER=$(which #{CREW_TGT}-gcc) \
                      -DCMAKE_CXX_COMPILER=$(which #{CREW_TGT}-g++) \
                      -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                      -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
                      -DCMAKE_LINKER=gold \
                      -DLLVM_USE_LINKER=gold \
                      -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
                      -DLLVM_LINK_LLVM_DYLIB=ON \
                      -DBUILD_SHARED_LIBS=ON \
                      -DLLVM_ENABLE_RTTI=ON \
                      -DCMAKE_C_FLAGS='#{@ARCH_C_LTO_FLAGS}' \
                      -DCMAKE_CXX_FLAGS='#{@ARCH_CXX_LTO_FLAGS}' \
                      -DCMAKE_EXE_LINKER_FLAGS='#{@ARCH_LTO_LDFLAGS}' \
                      -DPYTHON_EXECUTABLE=$(which python3) \
                      -DLLVM_ENABLE_ZLIB=ON \
                      -DLLVM_ENABLE_TERMINFO=ON ."
  def self.build
    FileUtils.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G Ninja #{@LLVM_CMAKE_OPTIONS} .."
      system "samu"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
