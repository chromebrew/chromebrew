require 'package'

class Musl_native_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  @musl_version = '7a43f6fea9081bdd53d8a11cef9e9fab0348c53d'
  # @_ver = (@musl_version[0, 7])
  version '1.2.3'
  license 'MIT, LGPL-2 and GPL-2'
  compatibility 'all'
  source_url 'https://git.zv.io/toolchains/musl-cross-make.git'
  git_hashtag '53280e53a32202a0ee874911fc52005874db344b'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.3_armv7l/musl_native_toolchain-1.2.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.3_armv7l/musl_native_toolchain-1.2.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.3_i686/musl_native_toolchain-1.2.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_native_toolchain/1.2.3_x86_64/musl_native_toolchain-1.2.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '71fe4ca61686a3675f7f5648fe3aae59b68f4c3c1e2678fabd215ec0f6be399e',
     armv7l: '71fe4ca61686a3675f7f5648fe3aae59b68f4c3c1e2678fabd215ec0f6be399e',
       i686: 'd29dcaab5ada61d0d0a0451d5fbf079f2f294457abd0d9ce4fb46cb73f5f74db',
     x86_64: '332322c230a6f18e35c5a145386021d74c77c6191e51b4c647ef63bbc04dae28'
  })

  # These libraries need to be built with the same version of gcc
  # as being built below, as the LTO versions need to match.
  depends_on 'zlibpkg' => :build
  depends_on 'zstd' => :build

  is_musl
  conflicts_ok

  @archflags = ''
  @linux_ver = '4.14.275'
  @target_tuple = "#{ARCH}-linux-musl"
  @gcc_version = '11-20220402'

  case ARCH
  when 'aarch64', 'armv7l'
    @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-fpu=neon --with-tune=cortex-a15'
    @target_tuple = 'armv7l-linux-musleabihf'
  when 'i686'
    @linux_ver = '3.8.12'
  end

  def self.patch
    FileUtils.mkdir_p "patches/musl-git-#{@musl_version}" if ARCH == 'i686'
    # Patch via discussion on musl mailing list with Rich Felker
    # working out issues on i686 Chromebooks for musl.
    # https://www.openwall.com/lists/musl/2022/02/18/1
    @i686_broken_kernel_patch = <<~BROKEN_KERNEL_PATCH_EOF
      --- a/arch/i386/syscall_arch.h	2022-02-17 16:45:37.398583011 -0500
      +++ b/arch/i386/syscall_arch.h	2022-02-17 16:50:02.311265598 -0500
      @@ -9,11 +9,21 @@
       #define SYSCALL_INSNS "call *%%gs:16"
       #endif

      +/*
      + *  * This error code is special: arch syscall entry code will return
      + *   * -ENOSYS if users try to call a syscall that doesn't exist.  To keep
      + *    * failures of syscalls that really do exist distinguishable from
      + *     * failures due to attempts to use a nonexistent syscall, syscall
      + *      * implementations should refrain from returning -ENOSYS.
      + *       */
      +#define ENOSYS          38      /* Invalid system call number */
      +
       #define SYSCALL_INSNS_12 "xchg %%ebx,%%edx ; " SYSCALL_INSNS " ; xchg %%ebx,%%edx"
       #define SYSCALL_INSNS_34 "xchg %%ebx,%%edi ; " SYSCALL_INSNS " ; xchg %%ebx,%%edi"

       static inline long __syscall0(long n)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       	__asm__ __volatile__ (SYSCALL_INSNS : "=a"(__ret) : "a"(n) : "memory");
       	return __ret;
      @@ -21,6 +31,7 @@

       static inline long __syscall1(long n, long a1)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       	__asm__ __volatile__ (SYSCALL_INSNS_12 : "=a"(__ret) : "a"(n), "d"(a1) : "memory");
       	return __ret;
      @@ -28,6 +39,7 @@

       static inline long __syscall2(long n, long a1, long a2)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       	__asm__ __volatile__ (SYSCALL_INSNS_12 : "=a"(__ret) : "a"(n), "d"(a1), "c"(a2) : "memory");
       	return __ret;
      @@ -35,6 +47,7 @@

       static inline long __syscall3(long n, long a1, long a2, long a3)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       #if !defined(__PIC__) || !defined(BROKEN_EBX_ASM)
       	__asm__ __volatile__ (SYSCALL_INSNS : "=a"(__ret) : "a"(n), "b"(a1), "c"(a2), "d"(a3) : "memory");
      @@ -46,6 +59,7 @@

       static inline long __syscall4(long n, long a1, long a2, long a3, long a4)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       #if !defined(__PIC__) || !defined(BROKEN_EBX_ASM)
       	__asm__ __volatile__ (SYSCALL_INSNS : "=a"(__ret) : "a"(n), "b"(a1), "c"(a2), "d"(a3), "S"(a4) : "memory");
      @@ -57,6 +71,7 @@

       static inline long __syscall5(long n, long a1, long a2, long a3, long a4, long a5)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       #if !defined(__PIC__) || !defined(BROKEN_EBX_ASM)
       	__asm__ __volatile__ (SYSCALL_INSNS
      @@ -70,6 +85,7 @@

       static inline long __syscall6(long n, long a1, long a2, long a3, long a4, long a5, long a6)
       {
      +	if (n>350) return -ENOSYS;
       	unsigned long __ret;
       #if !defined(__PIC__) || !defined(BROKEN_EBX_ASM)
       	__asm__ __volatile__ ("pushl %7 ; push %%ebp ; mov 4(%%esp),%%ebp ; " SYSCALL_INSNS " ; pop %%ebp ; add $4,%%esp"
    BROKEN_KERNEL_PATCH_EOF
    # Patch only needed for i686 due to issues with
    # ChromeOS 3.8.11 kernel.
    if ARCH == 'i686'
      File.write("patches/musl-git-#{@musl_version}/i686_broken_kernel.patch",
                 @i686_broken_kernel_patch)
    end
    @config_mak = <<~CONFIG_MAK_EOF
      # Not building with static results in a toolchain built against
      # glibc, which isn't what we want.
      STAT = -static --static

      FLAG = -g0 -O2 -pipe -fno-align-functions -fno-align-jumps -fno-align-loops -fno-align-labels -Wno-error -fPIC

      ifneq (\$(NATIVE),)
      COMMON_CONFIG += LIBRARY_PATH=#{CREW_MUSL_PREFIX}/lib:#{CREW_LIB_PREFIX} CC="\$(HOST)-gcc \${STAT}" CXX="\$(HOST)-g++ \${STAT}" FC="\$(HOST)-gfortran \${STAT}"
      else
      COMMON_CONFIG += LIBRARY_PATH=#{CREW_MUSL_PREFIX}/lib:#{CREW_LIB_PREFIX} CC="gcc \${STAT}" CXX="g++ \${STAT}" FC="gfortran \${STAT}"
      endif

      COMMON_CONFIG += CFLAGS="\${FLAG}" CXXFLAGS="\${FLAG}" FFLAGS="\${FLAG}" LDFLAGS="-s -L#{CREW_LIB_PREFIX} \${STAT}"

      BINUTILS_CONFIG += --enable-gold --enable-plugins --enable-64-bit-bfd
      GCC_CONFIG += --enable-default-pie --enable-static-pie --disable-cet --with-gcc-major-version-only #{@archflags} ZSTD_INC=#{CREW_PREFIX}/include ZSTD_LIB='#{CREW_LIB_PREFIX}/libzstd.a -pthread'

      # MUSL_CONFIG += --enable-debug

      CONFIG_SUB_REV = 888c8e3d5f7b
      GCC_VER = #{@gcc_version}
      BINUTILS_VER = 2.38
      # Newer musl versions cause breakage on i686 due to an issue with
      # the ancient 3.8 kernel on there.
      MUSL_VER = git-#{@musl_version}
      GMP_VER = 6.2.1
      ISL_VER = 0.23
      MPC_VER = 1.2.1
      MPFR_VER = 4.1.0
      LINUX_VER = #{@linux_ver}

      TARGET = #{@target_tuple}

      OUTPUT = #{CREW_DEST_MUSL_PREFIX}
    CONFIG_MAK_EOF
    File.write('config.mak', @config_mak)
    File.write('hashes/linux-3.8.12.tar.xz.sha1',
               '13d4f4f8f447b721e4a18ca39ed60fb7055d1de1 linux-3.8.12.tar.xz')
    File.write('hashes/linux-4.14.275.tar.xz.sha1',
               '300405963f79403dc8dfa9404f23e48b263ec796 linux-4.14.275.tar.xz')
    File.write('hashes/binutils-2.38.tar.xz.sha1',
               '15d42de8f15404a4a43a912440cf367f994779d7 binutils-2.38.tar.xz')
    File.write('hashes/gcc-11-20220108.tar.xz.sha1',
               'f89942362a87cb9c49f53177e7fcc57c77238197 gcc-11-20220108.tar.xz')
    File.write('hashes/gcc-11-20220205.tar.xz.sha1',
               'bf47c2deb318a84daad4b5773c1cbd3e93b9c637 gcc-11-20220205.tar.xz')
    File.write('hashes/gcc-11-20220212.tar.xz.sha1',
               '7c12dfccd75678cf7df65cccae94406b5a326b52 gcc-11-20220212.tar.xz')
    File.write('hashes/gcc-11-20220402.tar.xz.sha1',
               '5c8ee76fedec6ac8112d8a351721ae26045489cf gcc-11-20220402.tar.xz')
    # File.write("hashes/gcc-#{@gcc_version}.tar.xz.sha1",
    #           "634ee2483dbebb23fd32edff0ebb93924524e5a2 gcc-#{@gcc_version}.tar.xz")
    FileUtils.mv 'patches/gcc-11-20211120', "patches/gcc-#{@gcc_version}"
  end

  def self.build
    # This avoids an issue with the system zstd library being detected
    # but not used, which makes the build fail.
    system "make || ( (grep -rl \"ZSTD_INC =\" . | xargs sed -i 's,ZSTD_INC =,ZSTD_INC = #{CREW_PREFIX}/include ,g'; \
    grep -rl \"ZSTD_LIB =\" . | xargs sed -i 's,ZSTD_LIB =,ZSTD_LIB = #{CREW_LIB_PREFIX}/libzstd.a -pthread ,g') && make)"
  end

  def self.install
    load "#{CREW_LIB_PATH}/lib/musl.rb"
    system "OUTPUT=#{CREW_DEST_MUSL_PREFIX} make install"
    # Delete libc symlink made to syslibdir
    FileUtils.rm_f "#{CREW_DEST_MUSL_PREFIX}/usr/local"
    # copy everything to standard locations
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}") do
      system 'cp -r * ../'
    end
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/lib") do
      # Delete broken symlink pointing to /lib/libc.so
      FileUtils.rm_f "#{CREW_DEST_MUSL_PREFIX}/lib/ld-musl-#{MUSL_ARCH}.so.1"
      FileUtils.ln "#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}/lib/libc.so",
                   "#{CREW_DEST_MUSL_PREFIX}/lib/ld-musl-#{MUSL_ARCH}.so.1", force: true
      FileUtils.ln "#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}/lib/libc.so", "#{CREW_DEST_MUSL_PREFIX}/lib/libc.so",
                   force: true
    end
    return unless ARCH == 'i686'

    # perl needs this.
    FileUtils.ln_sf "#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}/include/locale.h",
                    "#{CREW_DEST_MUSL_PREFIX}/#{@target_tuple}/include/xlocale.h"
  end
end
