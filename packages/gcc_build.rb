require 'English'
require 'package'

class Gcc_build < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  @gcc_libc_version = '2.41'
  version '15.1.0'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://github.com/gcc-mirror/gcc.git'
  git_hashtag '911cfea5e59798e04479ad475870935ccfae004b'
  # git_hashtag "releases/gcc-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c1154d79059d28e95fd1d8c2ea13d9dd68d1c2e3f167f244adf8673da210ee1',
     armv7l: '7c1154d79059d28e95fd1d8c2ea13d9dd68d1c2e3f167f244adf8673da210ee1',
       i686: '3548d759835e8c5cc3c7767dd94af2247d866c5b292e1b7c58a53a75537acc57',
     x86_64: 'f8eb20a74cb6799354fbb58fff32849f533b48398e754dcd1a538372298bfa8d'
  })

  depends_on 'binutils' => :build
  depends_on 'dejagnu' => :build # for test
  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'isl' # R
  depends_on 'libssp' # L
  depends_on 'mpc' # R
  depends_on 'mpfr' # R
  depends_on 'rust' => :build
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  conflicts_ok
  # no_env_options
  no_mold

  @gcc_version = version.split('-')[0].partition('.')[0]

  @glibc_flags = ''
  # @gcc_version = `gcc -dumpversion`.chomp
  # @gcc_arch = `gcc -dumpmachine`.chomp
  # @gcc_dir = "gcc/#{@gcc_arch}/#{@gcc_version}"
  # @cflags = @cxxflags = "-fPIC -pipe #{@glibc_flags} -I#{CREW_PREFIX}/include"
  # @cflags = @cxxflags = "-fPIC -pipe #{@glibc_flags} -fno-stack-protector -D_FORTIFY_SOURCE=0"
  # @cflags = @cxxflags = "-fPIC -pipe #{@glibc_flags} -fcf-protection=none"
  @cflags = @cxxflags = "-fPIC -pipe #{@glibc_flags}"
  @languages = 'c,c++,jit,objc,fortran,go,rust'
  case ARCH
  when 'armv7l', 'aarch64'
    @archflags = '--with-arch=armv7-a+fp --with-float=hard --with-tune=cortex-a15 --with-fpu=vfpv3-d16'
  when 'x86_64'
    @archflags = '--with-arch-64=x86-64'
  when 'i686'
    @archflags = '--with-arch-32=i686'
  end
  @ldflags = @glibc_flags
  @path = "#{CREW_PREFIX}/share/cargo/bin:" + ENV.fetch('PATH', nil)

  def self.patch
    # make sure we are using our shell instead of /bin/sh
    system "grep -rlZ '/bin/sh ' . | xargs -0 sed -i 's,/bin/sh ,#{CREW_PREFIX}/bin/sh ,g'"
    system "grep -rlZ \"/bin/sh\\\"\" . | xargs -0 sed -i 's,/bin/sh\",#{CREW_PREFIX}/bin/sh\",g'"
    system "grep -rlZ \"/bin/sh'\" . | xargs -0 sed -i \"s,/bin/sh',#{CREW_PREFIX}/bin/sh',g\""

    # This fixes a PATH_MAX undefined error which breaks libsanitizer
    # "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    # This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    # and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    # The following is due to sed not passing newlines right.
    return unless system 'grep -q 4096 libsanitizer/asan/asan_linux.cpp', exception: false

    system "sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp"
    system "sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp"
    system "sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp"
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
  end

  def self.build
    @gcc_global_opts = <<~OPT.chomp
      --build=#{CREW_TARGET} \
      --host=#{CREW_TARGET} \
      --target=#{CREW_TARGET} \
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
      --enable-link-serialization=1 \
      --enable-linker-plugin-configure-flags='--host=#{CREW_TARGET} --target=#{CREW_TARGET}' \
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
      --with-newlib \
      --with-pic \
      --with-system-libunwind \
      --with-system-zlib \
      --with-system-zstd \
      --with-stage1-ldflags='#{@glibc_flags}' \
      --with-boot-ldflags='#{@glibc_flags}'
    OPT
    puts 'Building with:'.lightblue
    puts @gcc_global_opts.lightblue
    # Install prereqs using the standard gcc method so they can be
    # linked statically.
    # system './contrib/download_prerequisites'

    FileUtils.mkdir_p 'objdir/gcc/.deps'

    Dir.chdir('objdir') do
      build_env =
        {
                       build_configargs: @gcc_global_opts,
                                     AR: 'gcc-ar',
                                 CFLAGS: @cflags,
      CREW_PRELOAD_ENABLE_COMPILE_HACKS: '1',
                               CXXFLAGS: @cxxflags,
                             LD_PRELOAD: "#{CREW_LIB_PREFIX}/crew-preload.so",
                                LDFLAGS: @ldflags,
                           LIBRARY_PATH: CREW_LIB_PREFIX,
                                     LD: 'ld',
                                     NM: 'gcc-nm',
                                   PATH: @path,
                                 RANLIB: 'gcc-ranlib'
        }.transform_keys(&:to_s)

      system build_env, "../configure #{CREW_CONFIGURE_OPTIONS} \
          #{@gcc_global_opts} \
          #{@archflags} \
          --with-native-system-header-dir=#{CREW_PREFIX}/include \
          --enable-languages=#{@languages} \
          --program-suffix=-#{@gcc_version}"
      # Concurrent build sometimes breaks.
      system 'make'
      system 'make -j1' if $CHILD_STATUS.exitstatus != 0
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
      system "make -C #{CREW_TARGET}/libgcc DESTDIR=#{CREW_DEST_DIR} install-shared"

      @gcc_libs = %w[libatomic libgfortran libgo libgomp libitm
                     libquadmath libsanitizer/asan libsanitizer/lsan libsanitizer/ubsan
                     libsanitizer/tsan libstdc++-v3/src libvtv]
      @gcc_libs.each do |lib|
        system "make -C #{CREW_TARGET}/#{lib} \
          DESTDIR=#{CREW_DEST_DIR} install-toolexeclibLTLIBRARIES", exception: false
      end

      system "make -C #{CREW_TARGET}/libobjc DESTDIR=#{CREW_DEST_DIR} install-libs", exception: false
      system "make -C #{CREW_TARGET}/libstdc++-v3/po DESTDIR=#{CREW_DEST_DIR} install", exception: false
      system "make -C #{CREW_TARGET}/libphobos DESTDIR=#{CREW_DEST_DIR} install", exception: false

      # gcc_libs_info
      %w[libgomp libitm libquadmath].each do |lib|
        system "make -C #{CREW_TARGET}/#{lib} DESTDIR=#{CREW_DEST_DIR} install-info", exception: false
      end

      system "make DESTDIR=#{CREW_DEST_DIR} install-strip"

      # gcc-non-lib install
      system "make -C gcc DESTDIR=#{CREW_DEST_DIR} install-driver install-cpp install-gcc-ar \
        c++.install-common install-headers install-plugin install-lto-wrapper"

      %w[gcov gcov-tool].each do |gcov_bin|
        FileUtils.install "gcc/#{gcov_bin}", "#{CREW_DEST_PREFIX}/bin/#{gcov_bin}-#{@gcc_version}", mode: 0o755
      end

      FileUtils.mkdir_p gcc_libdir

      %w[cc1 cc1plus collect2 lto1].each do |lib|
        FileUtils.install "gcc/#{lib}", "#{gcc_libdir}/", mode: 0o755
      end

      system "make -C #{CREW_TARGET}/libgcc DESTDIR=#{CREW_DEST_DIR} install"

      %w[src include libsupc++ python].each do |lib|
        system "make -C #{CREW_TARGET}/libstdc++-v3/#{lib} DESTDIR=#{CREW_DEST_DIR} install"
      end

      system "make DESTDIR=#{CREW_DEST_DIR} install-libcc1"

      # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      # move a misplaced file
      # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory.
      # This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      FileUtils.mv Dir["#{CREW_DEST_LIB_PREFIX}/*gdb.py"], "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib/"

      system "make DESTDIR=#{CREW_DEST_DIR} install-fixincludes"
      system "make -C gcc DESTDIR=#{CREW_DEST_DIR} install-mkheaders"

      system "make -C lto-plugin DESTDIR=#{CREW_DEST_DIR} install"

      system "make -C #{CREW_TARGET}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS",
             exception: false
      system "make -C #{CREW_TARGET}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS",
             exception: false
      system "make -C #{CREW_TARGET}/libitm DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS",
             exception: false
      system "make -C #{CREW_TARGET}/libquadmath DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS",
             exception: false
      system "make -C #{CREW_TARGET}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_sanincludeHEADERS",
             exception: false
      system "make -C #{CREW_TARGET}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS",
             exception: false
      system install_env,
             "make -C #{CREW_TARGET}/libsanitizer/asan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS", exception: false
      # This failed on i686
      system install_env,
             "make -C #{CREW_TARGET}/libsanitizer/tsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS", exception: false
      # This might fail on i686
      system install_env,
             "make -C #{CREW_TARGET}/libsanitizer/lsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS", exception: false

      # libiberty is installed from binutils
      # system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      #      LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      #      make -C libiberty DESTDIR=#{CREW_DEST_DIR} install"
      # install -m644 libiberty/pic/libiberty.a "#{CREW_DEST_PREFIX}/lib"

      system "make -C gcc DESTDIR=#{CREW_DEST_DIR} install-man install-info"

      system "make -C libcpp DESTDIR=#{CREW_DEST_DIR} install"
      system "make -C gcc DESTDIR=#{CREW_DEST_DIR} install-po"

      # install the libstdc++ man pages
      # This is broken in 14.0.1
      # system "make -C #{CREW_TARGET}/libstdc++-v3/doc DESTDIR=#{CREW_DEST_DIR} doc-install-man"

      # byte-compile python libraries
      system "python -m compileall #{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}/"
      system "python -O -m compileall #{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}"
    end

    Dir.chdir "#{CREW_DEST_MAN_PREFIX}/man1" do
      Dir["*-#{@gcc_version}.1*"].each do |f|
        basefile = f.gsub("-#{@gcc_version}", '')
        FileUtils.ln_sf f, basefile
      end
    end

    Dir.chdir "#{CREW_DEST_PREFIX}/bin/" do
      Dir["#{gcc_arch}-*-#{@gcc_version}"].each do |f|
        basefile_nover = f.delete_suffix("-#{@gcc_version}")

        basefile_noarch = f.delete_prefix("#{gcc_arch}-")
        FileUtils.ln_sf f, basefile_noarch, verbose: true

        basefile_noarch_nover = basefile_nover.delete_prefix("#{gcc_arch}-")
        FileUtils.ln_sf f, basefile_noarch_nover, verbose: true

        basefile_noarch_nover_nogcc = basefile_noarch_nover.delete_prefix('gcc-')
        FileUtils.ln_sf f, "#{gcc_arch}-#{basefile_noarch_nover_nogcc}", verbose: true
      end

      Dir["*-#{@gcc_version}"].each do |f|
        basefile_nover = f.delete_suffix("-#{@gcc_version}")
        FileUtils.ln_sf f, basefile_nover, verbose: true
      end

      # many packages expect this symlink
      FileUtils.ln_sf "gcc-#{@gcc_version}", 'cc', verbose: true
    end

    # make sure current version of gcc LTO plugin for Gold linker is installed.
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/"
    FileUtils.ln_sf "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_DEST_LIB_PREFIX}/bfd-plugins/",
                    verbose: true

    # binutils makes a symlink here, but just in case it isn't there.
    if ARCH_LIB == 'lib64'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/bfd-plugins/"
      FileUtils.ln_sf "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_DEST_PREFIX}/lib/bfd-plugins/",
                      verbose: true
    end

    File.write "#{CREW_DEST_PREFIX}/bin/c99", @C99, perm: 0o755
    File.write "#{CREW_DEST_PREFIX}/bin/c89", @C89, perm: 0o755
  end

  def self.postinstall
    # remove any previous gcc packages
    @device = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'), symbolize_names: true).transform_values! { |val| val.is_a?(String) ? val.to_sym : val }

    installed_gcc = @device[:installed_packages].select { |pkg| pkg[:name] =~ /^gcc\d+$/ }

    installed_gcc.each do |gcc_pkg|
      puts "Removing previous version of gcc (#{gcc_pkg[:name]})...".yellow

      # remove filelist and directorylist
      FileUtils.rm_f(["#{CREW_META_PATH}/#{gcc_pkg[:name]}.filelist",
                      "#{CREW_META_PATH}/#{gcc_pkg[:name]}.directorylist"])

      # delete gcc#{ver} from device.json
      @device[:installed_packages].delete_if { |pkg| pkg[:name] == gcc_pkg[:name] }
    end

    # update device.json
    File.write("#{CREW_CONFIG_PATH}/device.json", JSON.pretty_generate(@device))
  end
end
