require 'package'

class Llvm_11 < Package
  description 'The LLVM Core libraries provide a modern source- and target-independent optimizer, along with code generation support.'
  homepage 'https://llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-llvm-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.0.1/llvm-11.0.1.src.tar.xz'
  source_sha256 'ccd87c254b6aebc5077e4e6977d08d4be888e7eb672c6630a26a15d58b59b528'

  depends_on 'zlibpkg'
  depends_on 'ncurses'
  depends_on 'libffi'
  depends_on 'libxml2'
  depends_on 'cmake' => :build
  depends_on 'perl' => :build
  depends_on 'pkgconfig' => :build
  depends_on 'binutils' => :build

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
  @ARCH_C_LTO_FLAGS = "#{@ARCH_C_FLAGS} -flto=auto -fuse-ld=gold"
  @ARCH_CXX_LTO_FLAGS = "#{@ARCH_CXX_FLAGS} -flto=auto -fuse-ld=gold"

  @LLVM_CMAKE_OPTIONS = "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                      -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
                      -DCMAKE_BUILD_TYPE=Release \
                      -DLLVM_ENABLE_LTO=On \
                      -DCMAKE_C_COMPILER=$(which #{CREW_TGT}-gcc) \
                      -DCMAKE_CXX_COMPILER=$(which #{CREW_TGT}-g++) \
                      -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
                      -DLLVM_DEFAULT_TARGET_TRIPLE=#{CREW_TGT} \
                      -DLLVM_LIBDIR_SUFFIX='#{CREW_LIB_SUFFIX}' \
                      -DCMAKE_LINKER=$(which ld.gold) \
                      -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
                      -DLLVM_BUILD_LLVM_DYLIB=ON \
                      -DLLVM_LINK_LLVM_DYLIB=ON \
                      -DLLVM_ENABLE_FFI=ON \
                      -DLLVM_ENABLE_RTTI=ON \
                      -DCMAKE_C_FLAGS='#{@ARCH_C_LTO_FLAGS}' \
                      -DCMAKE_CXX_FLAGS='#{@ARCH_CXX_LTO_FLAGS}' \
                      -DCMAKE_EXE_LINKER_FLAGS='#{@ARCH_LTO_LDFLAGS}' \
                      -DLLVM_PARALLEL_COMPILE_JOBS=$(($(nproc) + $(nproc))) \
                      -DLLVM_PARALLEL_LINK_JOBS=$(nproc) \
                      -DPYTHON_EXECUTABLE=$(which python3) \
                      -DLLVM_INSTALL_UTILS=ON \
                      -DLLVM_ENABLE_ZLIB=ON \
                      -DLLVM_BINUTILS_INCDIR='#{CREW_PREFIX}/include' \
                      -DLLVM_OPTIMIZED_TABLEGEN=ON \
                      -DLLVM_ENABLE_TERMINFO=ON ."
  def self.build
    FileUtils.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G Ninja #{@LLVM_CMAKE_OPTIONS} .."
      system "ninja"
    end
  end

  def self.check
    Dir.chdir "builddir" do
      system 'ninja', 'test'
    end
  end

  def self.install
    Dir.chdir "builddir" do
      system "DESTDIR=#{CREW_DEST_DIR}", 'ninja', 'install'
    end
  end

  def self.postinstall

  end
end
