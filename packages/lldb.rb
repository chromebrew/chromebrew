require 'package'

class Lldb < Package
  description 'The LLVM Debugger builds on libraries provided by LLVM and Clang to provide a great native debugger.'
  homepage 'https://lldb.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/lldb-11.1.0.src.tar.xz'
  source_sha256 'b273480ab46d32ebd65752e9be229da8c7940d158fa185fb20cffa5602789eee'

  depends_on 'llvm'
  depends_on 'binutils'
  depends_on 'xzutils'
  depends_on 'lua'
  depends_on 'swig'
  depends_on 'libedit'
  depends_on 'libxml2'
  depends_on 'python3'
  depends_on 'cmake' => :build
  depends_on 'perl' => :build
  depends_on 'pkgconfig' => :build
  depends_on 'linuxheaders' => :build

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
      system "cmake -G Ninja #{@LLVM_CMAKE_OPTIONS} \
              -DLLDB_ENABLE_LUA=ON \
              -DLLDB_ENABLE_LZMA=ON \
              -DLLDB_ENABLE_CURSES=ON \
              -DLLDB_ENABLE_LIBEDIT=ON \
              -DLLDB_ENABLE_LIBXML2=ON \
              -DLLDB_ENABLE_PYTHON=ON \
              -DCURSES_NCURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncursesw.so \
              -DPANEL_LIBRARIES=#{CREW_LIB_PREFIX}/libpanelw.so .."
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
