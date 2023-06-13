require 'package'

class Gcc10 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '10.4.0-1'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-10.4.0/gcc-10.4.0.tar.xz'
  source_sha256 'c9297d5bcd7cb43f3dfc2fed5389e948c9312fd962ef6a4ce455cff963ebe4f1'

  binary_url({
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc10/10.4.0-1_i686/gcc10-10.4.0-1-chromeos-i686.tar.zst',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc10/10.4.0-1_x86_64/gcc10-10.4.0-1-chromeos-x86_64.tar.zst',
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc10/10.4.0-1_armv7l/gcc10-10.4.0-1-chromeos-armv7l.tar.zst',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc10/10.4.0-1_armv7l/gcc10-10.4.0-1-chromeos-armv7l.tar.zst'
  })
  binary_sha256({
        i686: 'f1cd1b358a700b07400af645a324a26a6895cf8f2bc93d2b1c21782e2eb9b750',
      x86_64: 'd0f1cb59380cf1bf7806372752f8b3f9d472058cef7b63a33df3bfc18e9fb985',
     aarch64: 'dab3fe7fa5c509f18cc20e2c067e37363f3471688cfbd6c1d875bf1b71ce77b4',
      armv7l: 'dab3fe7fa5c509f18cc20e2c067e37363f3471688cfbd6c1d875bf1b71ce77b4'
  })

  depends_on 'binutils' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'isl' # R
  depends_on 'libssp' # L
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R
  depends_on 'gcc_lib' # R

  conflicts_ok
  no_env_options
  no_patchelf

  @gcc_version = version.split('-')[0].partition('.')[0]

  def self.patch
    # This fixes a PATH_MAX undefined error which breaks libsanitizer
    # "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    # This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    # and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    # The following is due to sed not passing newlines right.
    if system 'grep -q 4096 libsanitizer/asan/asan_linux.cpp', exception: false
      system "sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp"
      system "sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp"
      system "sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp"
    end
  end

  def self.build
    @gcc_global_opts = <<~OPT.chomp
      --disable-bootstrap \
      --disable-install-libiberty \
      --disable-libmpx \
      --disable-libssp \
      --disable-multilib \
      --disable-werror \
      --enable-cet=auto \
      --enable-checking=release \
      --enable-clocale=gnu \
      --enable-default-pie \
      --enable-default-ssp \
      --enable-gnu-indirect-function \
      --enable-gnu-unique-object \
      --enable-host-shared \
      --enable-lto \
      --enable-plugin \
      --enable-shared \
      --enable-symvers \
      --enable-static \
      --enable-threads=posix \
      --with-gcc-major-version-only \
      --with-gmp \
      --with-isl \
      --with-mpc \
      --with-mpfr \
      --with-pic \
      --with-system-libunwind \
      --with-system-zlib
    OPT

    @cflags = @cxxflags = '-fPIC -pipe'
    # @languages = 'c,c++,jit,objc,fortran,go'
    # go build fails on 20220305 snapshot
    @languages = 'c,c++,jit,objc,fortran'
    case ARCH
    when 'armv7l', 'aarch64'
      @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-tune=cortex-a15'
    when 'x86_64'
      @archflags = '--with-arch-64=x86-64'
    when 'i686'
      @archflags = '--with-arch-32=i686'
    end

    @path = "#{CREW_PREFIX}/bin:/usr/bin:/bin"

    # Install prereqs using the standard gcc method so they can be
    # linked statically.
    # system './contrib/download_prerequisites'

    FileUtils.mkdir_p 'objdir/gcc/.deps'

    Dir.chdir('objdir') do
      configure_env =
        {
          LIBRARY_PATH: CREW_LIB_PREFIX,
                    NM: 'gcc-nm',
                    AR: 'gcc-ar',
                RANLIB: 'gcc-ranlib',
                CFLAGS: @cflags,
              CXXFLAGS: @cxxflags,
               LDFLAGS: "-L#{CREW_LIB_PREFIX}/lib -Wl,-rpath=#{CREW_LIB_PREFIX}",
                  PATH: @path
        }.transform_keys(&:to_s)

      unless File.file?('Makefile')
        system configure_env, <<~BUILD.chomp
          ../configure #{CREW_OPTIONS} \
            #{@gcc_global_opts} \
            #{@archflags} \
            --with-native-system-header-dir=#{CREW_PREFIX}/include \
            --enable-languages=#{@languages} \
            --program-suffix=-#{@gcc_version}
        BUILD
      end

      # LIBRARY_PATH=#{CREW_LIB_PREFIX} needed for x86_64 to avoid:
      # /usr/local/bin/ld: cannot find crti.o: No such file or directory
      # /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
      system({ LIBRARY_PATH: CREW_LIB_PREFIX, PATH: @path }.transform_keys(&:to_s), 'make || make -j1')
    end
  end

  # preserve for check, skip check for current version
  def self.check
    # Dir.chdir('objdir') do
    #  system "make -k check -j#{CREW_NPROC} || true"
    #  system '../contrib/test_summary'
    # end
  end

  def self.install
    gcc_arch = `objdir/gcc/xgcc -dumpmachine`.chomp
    gcc_dir = "gcc/#{gcc_arch}/#{@gcc_version}"
    gcc_libdir = "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}"

    make_env =
      {
        LIBRARY_PATH: CREW_LIB_PREFIX,
                PATH: @path,
             DESTDIR: CREW_DEST_DIR
      }.transform_keys(&:to_s)

    Dir.chdir('objdir') do
      system make_env, "make DESTDIR=#{CREW_DEST_DIR} install-strip"

      # gcc-non-lib install
      system make_env, "make -C gcc DESTDIR=#{CREW_DEST_DIR} install-driver install-cpp install-gcc-ar \
        c++.install-common install-headers install-plugin install-lto-wrapper"

      %w[gcov gcov-tool].each do |gcov_bin|
        FileUtils.install "gcc/#{gcov_bin}", "#{CREW_DEST_PREFIX}/bin/#{gcov_bin}-#{@gcc_version}", mode: 0o755
      end

      FileUtils.mkdir_p gcc_libdir

      %w[cc1 cc1plus collect2 lto1].each do |lib|
        FileUtils.install "gcc/#{lib}", "#{gcc_libdir}/", mode: 0o755
      end

      system make_env, "make DESTDIR=#{CREW_DEST_DIR} install-fixincludes"
      system make_env, "make -C gcc DESTDIR=#{CREW_DEST_DIR} install-mkheaders"
    end

    # Remove files which would conflict with the current version of gcc.
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/*"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/include/libgccjit*.h"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/bin/armv7l-cros-linux-gnueabihf-gcc-tmp"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/share/locale/*"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/man/man7/*"
    FileUtils.rm_f "#{CREW_DEST_PREFIX}/share/info/*"
  end
end
