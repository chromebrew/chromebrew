require 'package'

class Libcxx < Package
  description 'libc++, along with libc++ ABI, provides a standard conformant and high-performance implementation of the C++ Standard Library.'
  homepage 'https://libcxx.llvm.org/'
  version '11.1.0'
  license 'Apache-2.0-with-LLVM-exceptions'
  compatibility 'all'
  source_url 'https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/libcxx-11.1.0.src.tar.xz'
  source_sha256 'bb233d250ed7eaa05c73eaf81ef0f9ee3fac9d8fc0c3d38a7a7383f82ed6f8e5'

  depends_on 'llvm'
  depends_on 'libunwind'
  depends_on 'cmake' => :build
  depends_on 'perl' => :build
  depends_on 'pkgconfig' => :build
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
                      -DLIBCXXABI_USE_LLVM_UNWINDER=OFF \
                      -DLIBCXXABI_USE_COMPILER_RT=OFF \
                      -D_CMAKE_TOOLCHAIN_PREFIX=llvm- \
                      -DLLVM_LINK_LLVM_DYLIB=ON \
                      -DLLVM_ENABLE_RTTI=ON \
                      -DCMAKE_C_FLAGS='#{@ARCH_C_LTO_FLAGS}' \
                      -DCMAKE_CXX_FLAGS='#{@ARCH_CXX_LTO_FLAGS}' \
                      -DCMAKE_EXE_LINKER_FLAGS='#{@ARCH_LTO_LDFLAGS}' \
                      -DPYTHON_EXECUTABLE=$(which python3) \
                      -DLLVM_ENABLE_ZLIB=ON \
                      -DLLVM_ENABLE_TERMINFO=ON ."

  def self.prebuild
    FileUtils.mkdir_p 'libcxx'
    system 'mv * libcxx || true' # Ruby's Dir.glob won't work
    system "curl -#LO https://github.com/llvm/llvm-project/releases/download/llvmorg-11.1.0/libcxxabi-11.1.0.src.tar.xz"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("libcxxabi-11.1.0.src.tar.xz") ) == '143193ed80f8fa4d85211d6704a90789fb36aa65b69fd0c382a9f05ec370ecab'
    system "tar xf libcxxabi-11.1.0.src.tar.xz"
    FileUtils.mv "libcxxabi-11.1.0.src", "libcxxabi"
  end

  def self.build
    FileUtils.mkdir "builddir"
    Dir.chdir "builddir" do
      system "cmake -G Ninja #{@LLVM_CMAKE_OPTIONS} ../libcxxabi"
      system "ninja"
    end
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
