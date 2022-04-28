require 'package'
require 'open3'

class Gcc11 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '11.3'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://gcc.gnu.org/pub/gcc/releases/gcc-11.3.0/gcc-11.3.0.tar.xz'
  source_sha256 'b47cf2818691f5b1e21df2bb38c795fac2cfbd640ede2d0a5e1c89e338a3ac39'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc11/11.3_armv7l/gcc11-11.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc11/11.3_armv7l/gcc11-11.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc11/11.3_i686/gcc11-11.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gcc11/11.3_x86_64/gcc11-11.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fe81d80adeb677f352531308e2ccc9b5bce8d7bffe827c136440b7cc03da57fd',
     armv7l: 'fe81d80adeb677f352531308e2ccc9b5bce8d7bffe827c136440b7cc03da57fd',
       i686: 'afab8f5dff70482762fbc77d6e663b2dfd20498f5eb68d3d0f3b96b45659df03',
     x86_64: 'ed75e74c102547f84c73ae97e96604fedb06710a95390d1df0c74987caad9109'
  })

  depends_on 'ccache' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'isl' # R
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'libssp' # L
  depends_on 'zstd' # R
  no_env_options
  no_patchelf

  provides 'libs', 'GCC runtime libraries',
           lambda {|f| File.fnmatch("#{CREW_LIB_PREFIX}/*.so*", f) }

  @gcc_version = version.split('-')[0].partition('.')[0]

  # Reimplement gcc preflight section during gcc12 release cycle.
  # def self.preflight
  #   # Use full gcc path to bypass ccache
  #   stdout_and_stderr, status = Open3.capture2e('bash', '-c',
  #                                               "#{CREW_PREFIX}/bin/gcc -dumpversion 2>&1 | tail -1 | cut -d' ' -f1")
  #   if status.success?
  #     installed_gccver = stdout_and_stderr.chomp
  #     # One gets "-dumpversion" or "bash:" with no gcc installed.
  #     unless installed_gccver.to_s == '-dumpversion' ||
  #       installed_gccver.to_s == 'bash:' ||
  #       installed_gccver.to_s == @gcc_version.to_s ||
  #       installed_gccver.partition('.')[0].to_s == @gcc_version.partition('.')[0].to_s
  #       warn "GCC version #{installed_gccver} is currently installed.".lightred
  #       warn "To use #{to_s.downcase} please run:".lightgreen
  #       warn "crew remove gcc#{installed_gccver} && crew install #{to_s.downcase}".lightgreen
  #       exit 1
  #     end
  #   end
  # end

  def self.patch
    # This fixes a PATH_MAX undefined error which breaks libsanitizer
    # "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    # This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    # and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    # The following is due to sed not passing newlines right.
    system "grep  -q 4096 libsanitizer/asan/asan_linux.cpp || (sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp)"

    # Mold patches backported from GCC 12.
    @mold_patch = <<~MOLD_PATCH_EOF
      From ca60317a60ee20ce848b36588b905b5a63d81350 Mon Sep 17 00:00:00 2001
      From: Martin Liska <mliska@suse.cz>
      Date: Tue, 21 Dec 2021 17:43:55 +0100
      Subject: [PATCH] Support ld.mold linker.

      gcc/ChangeLog:

      	* collect2.c (main): Add ld.mold.
      	* common.opt: Add -fuse-ld=mold.
      	* doc/invoke.texi: Document it.
      	* gcc.c (driver_handle_option): Handle -fuse-ld=mold.
      	* opts.c (common_handle_option): Likewise.
      ---
       gcc/collect2.c      | 10 +++++++---
       gcc/common.opt      |  4 ++++
       gcc/doc/invoke.texi |  4 ++++
       gcc/gcc.c           |  4 ++++
       gcc/opts.c          |  1 +
       5 files changed, 20 insertions(+), 3 deletions(-)

      diff --git a/gcc/collect2.c b/gcc/collect2.c
      index d47fe3f9195..b322527847c 100644
      --- a/gcc/collect2.c
      +++ b/gcc/collect2.c
      @@ -776,6 +776,7 @@ main (int argc, char **argv)
             USE_GOLD_LD,
             USE_BFD_LD,
             USE_LLD_LD,
      +      USE_MOLD_LD,
             USE_LD_MAX
           } selected_linker = USE_DEFAULT_LD;
         static const char *const ld_suffixes[USE_LD_MAX] =
      @@ -784,7 +785,8 @@ main (int argc, char **argv)
             PLUGIN_LD_SUFFIX,
             "ld.gold",
             "ld.bfd",
      -      "ld.lld"
      +      "ld.lld",
      +      "ld.mold"
           };
         static const char *const real_ld_suffix = "real-ld";
         static const char *const collect_ld_suffix = "collect-ld";
      @@ -957,6 +959,8 @@ main (int argc, char **argv)
       	  selected_linker = USE_GOLD_LD;
       	else if (strcmp (argv[i], "-fuse-ld=lld") == 0)
       	  selected_linker = USE_LLD_LD;
      +	else if (strcmp (argv[i], "-fuse-ld=mold") == 0)
      +	  selected_linker = USE_MOLD_LD;
       	else if (startswith (argv[i], "-o"))
       	  {
       	    /* Parse the output filename if it's given so that we can make
      @@ -1048,7 +1052,7 @@ main (int argc, char **argv)
         ld_file_name = 0;
       #ifdef DEFAULT_LINKER
         if (selected_linker == USE_BFD_LD || selected_linker == USE_GOLD_LD ||
      -      selected_linker == USE_LLD_LD)
      +      selected_linker == USE_LLD_LD || selected_linker == USE_MOLD_LD)
           {
             char *linker_name;
       # ifdef HOST_EXECUTABLE_SUFFIX
      @@ -1283,7 +1287,7 @@ main (int argc, char **argv)
       	      else if (!use_collect_ld
       		       && startswith (arg, "-fuse-ld="))
       		{
      -		  /* Do not pass -fuse-ld={bfd|gold|lld} to the linker. */
      +		  /* Do not pass -fuse-ld={bfd|gold|lld|mold} to the linker. */
       		  ld1--;
       		  ld2--;
       		}
      diff --git a/gcc/common.opt b/gcc/common.opt
      index 2ed818d6057..dba3fa886f9 100644
      --- a/gcc/common.opt
      +++ b/gcc/common.opt
      @@ -3046,6 +3046,10 @@ fuse-ld=lld
       Common Driver Negative(fuse-ld=lld)
       Use the lld LLVM linker instead of the default linker.
      #{' '}
      +fuse-ld=mold
      +Common Driver Negative(fuse-ld=mold)
      +Use the Modern linker (MOLD) linker instead of the default linker.
      +
       fuse-linker-plugin
       Common Undocumented Var(flag_use_linker_plugin)
      #{' '}
      diff --git a/gcc/doc/invoke.texi b/gcc/doc/invoke.texi
      index e644c63767b..54fa75ba138 100644
      --- a/gcc/doc/invoke.texi
      +++ b/gcc/doc/invoke.texi
      @@ -16266,6 +16266,10 @@ Use the @command{gold} linker instead of the default linker.
       @opindex fuse-ld=lld
       Use the LLVM @command{lld} linker instead of the default linker.
      #{' '}
      +@item -fuse-ld=mold
      +@opindex fuse-ld=mold
      +Use the Modern Linker (@command{mold}) instead of the default linker.
      +
       @cindex Libraries
       @item -l@var{library}
       @itemx -l @var{library}
      diff --git a/gcc/gcc.c b/gcc/gcc.c
      index b75b50b87b2..06e18a75b52 100644
      --- a/gcc/gcc.c
      +++ b/gcc/gcc.c
      @@ -4282,6 +4282,10 @@ driver_handle_option (struct gcc_options *opts,
              use_ld = ".gold";
              break;
      #{' '}
      +    case OPT_fuse_ld_mold:
      +       use_ld = ".mold";
      +       break;
      +
           case OPT_fcompare_debug_second:
             compare_debug_second = 1;
             break;
      diff --git a/gcc/opts.c b/gcc/opts.c
      index e4e47ff77b3..f820052307c 100644
      --- a/gcc/opts.c
      +++ b/gcc/opts.c
      @@ -3105,6 +3105,7 @@ common_handle_option (struct gcc_options *opts,
           case OPT_fuse_ld_bfd:
           case OPT_fuse_ld_gold:
           case OPT_fuse_ld_lld:
      +    case OPT_fuse_ld_mold:
           case OPT_fuse_linker_plugin:
             /* No-op. Used by the driver and passed to us because it starts with f.*/
             break;
      --#{' '}
      2.34.1

      From: Martin Liska <mliska@suse.cz>
      Date: Thu, 3 Mar 2022 15:47:19 +0100
      Subject: [PATCH] configure: enable plugin support for ld.mold

      gcc/ChangeLog:

      	* configure.ac: Now ld.mold support LTO plugin API, use it.
      	* configure: Regenerate.
      ---
       gcc/configure    | 2 ++
       gcc/configure.ac | 2 ++
       2 files changed, 4 insertions(+)

      diff --git a/gcc/configure b/gcc/configure
      index 22eb3451e3d..6f5fc20fcf3 100755
      --- a/gcc/configure
      +++ b/gcc/configure
      @@ -26037,6 +26037,8 @@ if test -f liblto_plugin.la; then
           # Allow -fuse-linker-plugin to enable plugin support in GNU gold 2.20.
           elif test "$ld_is_gold" = yes -a "$ld_vers_major" -eq 2 -a "$ld_vers_minor" -eq 20; then
             gcc_cv_lto_plugin=1
      +    elif test "$ld_is_mold" = yes; then
      +      gcc_cv_lto_plugin=1
           fi
         fi
      #{' '}
      diff --git a/gcc/configure.ac b/gcc/configure.ac
      index 20da90901f8..3d85d33bc80 100644
      --- a/gcc/configure.ac
      +++ b/gcc/configure.ac
      @@ -4278,6 +4278,8 @@ changequote([,])dnl
           # Allow -fuse-linker-plugin to enable plugin support in GNU gold 2.20.
           elif test "$ld_is_gold" = yes -a "$ld_vers_major" -eq 2 -a "$ld_vers_minor" -eq 20; then
             gcc_cv_lto_plugin=1
      +    elif test "$ld_is_mold" = yes; then
      +      gcc_cv_lto_plugin=1
           fi
         fi
      #{' '}
      --#{' '}
      2.27.0
      From c083e654bd0f29a365ec957c4c0d4e713fb0b010 Mon Sep 17 00:00:00 2001
      From: Martin Liska <mliska@suse.cz>
      Date: Thu, 3 Mar 2022 17:28:45 +0100
      Subject: [PATCH] configure: use linker plug-in by default for ld.mold

      gcc/ChangeLog:

      	* configure.ac: Use linker plug-in by default.
      	* configure: Regenerate.
      ---
       gcc/configure    | 4 ++--
       gcc/configure.ac | 4 ++--
       2 files changed, 4 insertions(+), 4 deletions(-)

      diff --git a/gcc/configure b/gcc/configure
      index 6f5fc20fcf3..14b19c8fe0c 100755
      --- a/gcc/configure
      +++ b/gcc/configure
      @@ -26034,11 +26034,11 @@ if test -f liblto_plugin.la; then
           # Require GNU ld or gold 2.21+ for plugin support by default.
           if test "$ld_vers_major" -eq 2 -a "$ld_vers_minor" -ge 21; then
             gcc_cv_lto_plugin=2
      +    elif test "$ld_is_mold" = yes; then
      +      gcc_cv_lto_plugin=2
           # Allow -fuse-linker-plugin to enable plugin support in GNU gold 2.20.
           elif test "$ld_is_gold" = yes -a "$ld_vers_major" -eq 2 -a "$ld_vers_minor" -eq 20; then
             gcc_cv_lto_plugin=1
      -    elif test "$ld_is_mold" = yes; then
      -      gcc_cv_lto_plugin=1
           fi
         fi
      #{' '}
      diff --git a/gcc/configure.ac b/gcc/configure.ac
      index 3d85d33bc80..90cad309762 100644
      --- a/gcc/configure.ac
      +++ b/gcc/configure.ac
      @@ -4275,11 +4275,11 @@ changequote([,])dnl
           # Require GNU ld or gold 2.21+ for plugin support by default.
           if test "$ld_vers_major" -eq 2 -a "$ld_vers_minor" -ge 21; then
             gcc_cv_lto_plugin=2
      +    elif test "$ld_is_mold" = yes; then
      +      gcc_cv_lto_plugin=2
           # Allow -fuse-linker-plugin to enable plugin support in GNU gold 2.20.
           elif test "$ld_is_gold" = yes -a "$ld_vers_major" -eq 2 -a "$ld_vers_minor" -eq 20; then
             gcc_cv_lto_plugin=1
      -    elif test "$ld_is_mold" = yes; then
      -      gcc_cv_lto_plugin=1
           fi
         fi
      #{' '}
      --#{' '}
      2.27.0
    MOLD_PATCH_EOF
    File.write('mold.patch', @mold_patch)
    system 'patch -Np1 -F3 -i mold.patch'
  end

  def self.prebuild
    @C99 = <<~EOF
      #!/usr/bin/env sh
      fl="-std=c99"
      for opt; do
        case "$opt" in
          -std=c99|-std=iso9899:1999) fl="";;
          -std=*) echo "`basename $0` called with non ISO C99 option $opt" >&2
              exit 1;;
        esac
      done
      exec gcc $fl ${1+"$@"}
    EOF

    @C89 = <<~EOF
      #!/usr/bin/env sh
      fl="-std=c89"
      for opt; do
        case "$opt" in
          -ansi|-std=c89|-std=iso9899:1990) fl="";;
          -std=*) echo "`basename $0` called with non ANSI/ISO C option $opt" >&2
                exit 1;;
        esac
      done
      exec gcc $fl ${1+"$@"}
    EOF
    File.write 'c99', @C99
    File.write 'c89', @C89
  end

  def self.build
    @gcc_global_opts = '--disable-bootstrap \
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
      --with-system-zlib'

    @cflags = '-fPIC -pipe'
    @cxxflags = '-fPIC -pipe'
    # @languages = 'c,c++,jit,objc,fortran,go'
    # go build fails on 20220305 snapshot
    @languages = 'c,c++,jit,objc,fortran'
    case ARCH
    when 'armv7l', 'aarch64'
      @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-fpu=neon --with-tune=cortex-a15'
    when 'x86_64'
      @archflags = '--with-arch-64=x86-64'
    when 'i686'
      @archflags = '--with-arch-32=i686'
    end

    # Set ccache sloppiness as per
    # https://wiki.archlinux.org/index.php/Ccache#Sloppiness
    system 'ccache --set-config=sloppiness=file_macro,locale,time_macros'
    # Prefix ccache to path.
    @path = "#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin"

    # Install prereqs using the standard gcc method so they can be
    # linked statically.
    # system './contrib/download_prerequisites'

    ## Install newer version of gmp
    # gmp_url = "https://gmplib.org/download/gmp/gmp-#{@gmp_ver}.tar.lz"
    # gmp_sha256 = '2c7f4f0d370801b2849c48c9ef3f59553b5f1d3791d070cffb04599f9fc67b41'
    # system "curl -Ls #{gmp_url} | hashpipe sha256 #{gmp_sha256} | tar --lzip -x"
    # system "ln -sf ../gmp-#{@gmp_ver} gmp"

    ## Install newer version of isl
    # isl_url = "http://isl.gforge.inria.fr/isl-#{@isl_ver}.tar.bz2"
    # isl_sha256 = 'c58922c14ae7d0791a77932f377840890f19bc486b653fa64eba7f1026fb214d'
    # system "curl -Ls #{isl_url} | hashpipe sha256 #{isl_sha256} | tar xj"
    # system "ln -sf ../isl-#{@isl_ver} isl"

    ## Install newer version of mpc
    # mpc_url = "https://ftp.gnu.org/gnu/mpc/mpc-#{@mpc_ver}.tar.gz"
    # mpc_sha256 = '17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459'
    # system "curl -Ls #{mpc_url} | hashpipe sha256 #{mpc_sha256} | tar xz"
    # system "ln -sf ../mpc-#{@mpc_ver} mpc"

    ## Install newer version of mpfr
    # mpfr_url = "https://www.mpfr.org/mpfr-current/mpfr-#{@mpfr_ver}.tar.xz"
    # mpfr_sha256 = '0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f'
    # system "curl -Ls #{mpfr_url} | hashpipe sha256 #{mpfr_sha256} | tar xJ"
    # Dir.chdir "mpfr-#{@mpfr_ver}" do
    #  system 'curl -Ls "https://gforge.inria.fr/scm/viewvc.php/mpfr/misc/www/mpfr-4.1.0/allpatches?revision=14491&view=co" | \
    #    hashpipe sha256 dfa7d8a14ec7cb3b344cb81cfd7bd7e22aba62379941cc9110759f11172ac013 | patch -NZp1 --binary'
    # end
    # system "ln -sf ../mpfr-#{@mpfr_ver} mpfr"

    FileUtils.mkdir_p 'objdir/gcc/.deps'

    Dir.chdir('objdir') do
      system "env NM=gcc-nm AR=gcc-ar RANLIB=gcc-ranlib \
        CFLAGS='#{@cflags}' CXXFLAGS='#{@cxxflags}' \
        LDFLAGS='-L#{CREW_LIB_PREFIX}/lib -Wl,-rpath=#{CREW_LIB_PREFIX}' \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        ../configure #{CREW_OPTIONS} \
        #{@gcc_global_opts} \
        #{@archflags} \
        --with-native-system-header-dir=#{CREW_PREFIX}/include \
        --enable-languages=#{@languages} \
        --program-suffix=-#{@gcc_version}"
      # LIBRARY_PATH=#{CREW_LIB_PREFIX} needed for x86_64 to avoid:
      # /usr/local/bin/ld: cannot find crti.o: No such file or directory
      # /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
      system "env PATH=#{@path} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        make"
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
    Dir.chdir('objdir') do
      # gcc-libs install
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -C #{CREW_TGT}/libgcc DESTDIR=#{CREW_DEST_DIR} install-shared"

      @gcc_libs = %w[libatomic libgfortran libgo libgomp libitm
                     libquadmath libsanitizer/asan libsanitizer/lsan libsanitizer/ubsan
                     libsanitizer/tsan libstdc++-v3/src libvtv]
      @gcc_libs.each do |lib|
        system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -C #{CREW_TGT}/#{lib} \
          DESTDIR=#{CREW_DEST_DIR} install-toolexeclibLTLIBRARIES || true"
      end

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libobjc DESTDIR=#{CREW_DEST_DIR} install-libs || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libstdc++-v3/po DESTDIR=#{CREW_DEST_DIR} install || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libphobos DESTDIR=#{CREW_DEST_DIR} install || true"

      @gcc_libs_info = %w[libgomp libitm libquadmath]
      @gcc_libs_info.each do |lib|
        system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -C #{CREW_TGT}/#{lib} DESTDIR=#{CREW_DEST_DIR} install-info || true"
      end

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make DESTDIR=#{CREW_DEST_DIR} install-strip"

      # gcc-non-lib install
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-driver install-cpp install-gcc-ar \
        c++.install-common install-headers install-plugin install-lto-wrapper"

      @gcov_install = %w[gcov gcov-tool]
      @gcov_install.each do |gcov_bin|
        FileUtils.install "gcc/#{gcov_bin}", "#{CREW_DEST_PREFIX}/bin/#{gcov_bin}-#{@gcc_version}", mode: 0o755
      end

      FileUtils.mkdir_p gcc_libdir
      @gcc_libdir_install = %w[cc1 cc1plus collect2 lto1]
      @gcc_libdir_install.each do |lib|
        FileUtils.install "gcc/#{lib}", "#{gcc_libdir}/", mode: 0o755
      end

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libgcc DESTDIR=#{CREW_DEST_DIR} install"

      @libstdc_install = %w[src include libsupc++]
      @libstdc_install.each do |lib|
        system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      make -C #{CREW_TGT}/libstdc++-v3/#{lib} DESTDIR=#{CREW_DEST_DIR} install"
      end
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libstdc++-v3/python DESTDIR=#{CREW_DEST_DIR} install"

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make DESTDIR=#{CREW_DEST_DIR} install-libcc1"

      # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      # move a misplaced file
      # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory.
      # This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      FileUtils.mv Dir.glob("#{CREW_DEST_LIB_PREFIX}/*gdb.py"),
                   "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib/"

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make DESTDIR=#{CREW_DEST_DIR} install-fixincludes"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-mkheaders"

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C lto-plugin DESTDIR=#{CREW_DEST_DIR} install"

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libitm DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libquadmath DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_sanincludeHEADERS || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer/asan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      # This failed on i686
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer/tsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      # This might fail on i686
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer/lsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"

      # libiberty is installed from binutils
      # system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      #      LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      #      make -C libiberty DESTDIR=#{CREW_DEST_DIR} install"
      # install -m644 libiberty/pic/libiberty.a "#{CREW_DEST_PREFIX}/lib"

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-man install-info"

      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C libcpp DESTDIR=#{CREW_DEST_DIR} install"
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-po"

      # install the libstdc++ man pages
      system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libstdc++-v3/doc DESTDIR=#{CREW_DEST_DIR} doc-install-man"

      # byte-compile python libraries
      system "python -m compileall #{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}/"
      system "python -O -m compileall #{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}"
    end

    Dir.chdir "#{CREW_DEST_MAN_PREFIX}/man1" do
      Dir.glob("*-#{@gcc_version}.1*").each do |f|
        @basefile = f.gsub("-#{@gcc_version}", '')
        FileUtils.ln_sf f, @basefile
      end
    end

    Dir.chdir "#{CREW_DEST_PREFIX}/bin/" do
      Dir.glob("#{gcc_arch}-*-#{@gcc_version}").each do |f|
        @basefile_nover = f.split(/-#{@gcc_version}/, 2).first
        puts "Symlinking #{f} to #{@basefile_nover}"
        FileUtils.ln_sf f, @basefile_nover
        @basefile_noarch = f.split(/#{gcc_arch}-/, 2).last
        puts "Symlinking #{f} to #{@basefile_noarch}"
        FileUtils.ln_sf f, @basefile_noarch
        @basefile_noarch_nover = @basefile_nover.split(/#{gcc_arch}-/, 2).last
        puts "Symlinking #{f} to #{@basefile_noarch_nover}"
        FileUtils.ln_sf f, @basefile_noarch_nover
        @basefile_noarch_nover_nogcc = @basefile_noarch_nover.split(/gcc-/, 2).last
        puts "Symlinking #{f} to #{gcc_arch}-#{@basefile_noarch_nover_nogcc}"
        FileUtils.ln_sf f, "#{gcc_arch}-#{@basefile_noarch_nover_nogcc}"
      end
      Dir.glob("*-#{@gcc_version}").each do |f|
        @basefile_nover = f.split(/-#{@gcc_version}/, 2).first
        puts "Symlinking #{f} to #{@basefile_nover}"
        FileUtils.ln_sf f, @basefile_nover
      end
      # many packages expect this symlink
      puts "Symlinking gcc-#{@gcc_version} to cc"
      FileUtils.ln_sf "gcc-#{@gcc_version}", 'cc'
    end
    # libgomp.so conflicts with llvm
    @deletefiles = %W[#{CREW_DEST_LIB_PREFIX}/libgomp.so]
    @deletefiles.each do |f|
      FileUtils.rm f if File.exist?(f)
    end
    # make sure current version of gcc LTO plugin for Gold linker is installed.
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    puts "Symlinking #{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so to #{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    FileUtils.ln_sf "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    # binutils makes a symlink here, but just in case it isn't there.
    if ARCH == 'x86_64'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/bfd-plugins/"
      puts "Symlinking #{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so to #{CREW_DEST_PREFIX}/lib/bfd-plugins/"
      FileUtils.ln_sf "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_DEST_PREFIX}/lib/bfd-plugins/"
    end
    FileUtils.install 'c99', "#{CREW_DEST_PREFIX}/bin/c99", mode: 0o755
    FileUtils.install 'c89', "#{CREW_DEST_PREFIX}/bin/c89", mode: 0o755
  end
end
