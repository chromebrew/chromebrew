require 'package'

class Gcc10 < Package
  description 'The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, and Go.'
  homepage 'https://www.gnu.org/software/gcc/'
  version '10.3.0'
  @isl_ver = '0.23'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://gcc.gnu.org/pub/gcc/releases/gcc-10.3.0/gcc-10.3.0.tar.xz'
  source_sha256 '64f404c1a650f27fc33da242e1f2df54952e3963a49e06e73f6940f3223ac344'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gcc10-10.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gcc10-10.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gcc10-10.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gcc10-10.3.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a76f2e18af60cd5eb9cfb118c4bd6c31a35be4f5ea617a0b6b22ce549030d494',
     armv7l: 'a76f2e18af60cd5eb9cfb118c4bd6c31a35be4f5ea617a0b6b22ce549030d494',
       i686: 'c5ff2877e7a3077b8bf2d0d8158a54a6a5483385bdbf685bcfa476be61a5886e',
     x86_64: '6e49cfe362cb7645b892c8454acc1822620fc8c3bc353249e24f6f8d8da10866'
  })

  depends_on 'dejagnu' => :build # for test
  depends_on 'ccache' => :build
  depends_on 'hashpipe' => :build
  depends_on 'glibc'
  depends_on 'isl'
  depends_on 'mpc'
  depends_on 'mpfr'
  depends_on 'gmp'

  def self.preinstall
    installed_gccver = `gcc -v 2>&1 | tail -1 | cut -d' ' -f3`.chomp
    gcc_version = version.split('-')[0]
    # match to 'version' for case of ccache in PATH
    unless installed_gccver.to_s == 'No' || installed_gccver.to_s == 'not' || installed_gccver.to_s == 'gcc:' || installed_gccver.to_s == 'version' || installed_gccver.to_s == gcc_version.to_s
      abort "GCC version #{installed_gccver} already installed.".lightgreen
    end
  end

  def self.build
    # Set ccache sloppiness as per
    # https://wiki.archlinux.org/index.php/Ccache#Sloppiness
    system 'ccache --set-config=sloppiness=file_macro,locale,time_macros'
    # Prefix ccache to path.
    @path = "#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin"

    # Install prereqs using the standard gcc method so they can be
    # linked statically.
    # system './contrib/download_prerequisites'

    # Install newer version of isl
    isl_url = "http://isl.gforge.inria.fr/isl-#{@isl_ver}.tar.bz2"
    isl_sha256 = 'c58922c14ae7d0791a77932f377840890f19bc486b653fa64eba7f1026fb214d'
    system "curl -Ls #{isl_url} | hashpipe sha256 #{isl_sha256} | tar xj"
    system "ln -sf ../isl-#{@isl_ver} isl"

    gcc_version = version.split('-')[0]

    # previous compile issue
    # /usr/local/bin/ld: cannot find crti.o: No such file or directory
    # /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
    # ENV['LIBRARY_PATH'] = CREW_LIB_PREFIX # fix x86_64 issues
    FileUtils.mkdir_p 'objdir/gcc/.deps'
    # This fixes a PATH_MAX undefined error which breaks libsanitizer
    # "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    # This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    # and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    # The following is due to sed not passing newlines right.
    system "grep  -q 4096 libsanitizer/asan/asan_linux.cpp || (sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp &&
    sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp)"
    # Fix "crtbeginT.o: relocation R_X86_64_32 against hidden symbol `__TMC_END__' can not be used when making a shared object"
    # when building static llvm
    system "sed -i 's/-fbuilding-libgcc -fno-stack-protector/-fbuilding-libgcc -fPIC -fno-stack-protector/g' libgcc/Makefile.in"
    Dir.chdir('objdir') do
      @cflags = '-fPIC'
      @cxxflags = '-fPIC'
      @languages = 'c,c++,jit,objc,fortran,go'
      case ARCH
      when 'armv7l', 'aarch64'
        system "env CFLAGS=#{@cflags} CXXFLAGS=#{@cxxflags} \
           LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
           LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          ../configure #{CREW_OPTIONS} \
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
          --enable-languages=#{@languages} \
          --enable-lto \
          --enable-plugin \
          --enable-shared \
          --enable-static \
          --enable-threads=posix \
          --program-suffix=-#{gcc_version} \
          --with-arch=armv7-a \
          --with-build-config=bootstrap-lto-lean \
          --with-float=hard \
          --with-fpu=neon \
          --with-isl \
          --with-pic \
          --with-system-zlib \
          --with-tune=cortex-a15"
      when 'x86_64'
        system "env CFLAGS=#{@cflags} CXXFLAGS=#{@cxxflags}  \
          LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          ../configure #{CREW_OPTIONS} \
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
          --enable-languages=#{@languages}  \
          --enable-lto \
          --enable-plugin \
          --enable-shared \
          --enable-static \
          --enable-threads=posix \
          --program-suffix=-#{gcc_version} \
          --with-arch-64=x86-64 \
          --with-build-config=bootstrap-lto-lean \
          --with-isl \
          --with-pic \
          --with-system-zlib"
      when 'i686'
        system "env CFLAGS=#{@cflags} CXXFLAGS=#{@cxxflags} \
          LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          ../configure  #{CREW_OPTIONS} \
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
          --enable-languages=#{@languages}  \
          --enable-lto \
          --enable-plugin \
          --enable-shared \
          --enable-static \
          --enable-threads=posix \
          --program-suffix=-#{gcc_version} \
          --with-arch-32=#{ARCH} \
          --with-build-config=bootstrap-lto-lean \
          --with-isl \
          --with-pic \
          --with-system-zlib"
      end
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -j4"
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
    Dir.chdir('objdir') do
      # gcc-libs install
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -C #{CREW_TGT}/libgcc DESTDIR=#{CREW_DEST_DIR} install-shared"

      @gcc_libs = %w[libatomic libgfortran libgo libgomp libitm
                     libquadmath libsanitizer/asan libsanitizer/lsan libsanitizer/ubsan
                     libsanitizer/tsan libstdc++-v3/src libvtv]
      @gcc_libs.each do |lib|
        system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -C #{CREW_TGT}/#{lib} \
          DESTDIR=#{CREW_DEST_DIR} install-toolexeclibLTLIBRARIES || true"
      end

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libobjc DESTDIR=#{CREW_DEST_DIR} install-libs || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libstdc++-v3/po DESTDIR=#{CREW_DEST_DIR} install || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libphobos DESTDIR=#{CREW_DEST_DIR} install || true"

      @gcc_libs_info = %w[libgomp libitm libquadmath]
      @gcc_libs_info.each do |lib|
        system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make -C #{CREW_TGT}/#{lib} DESTDIR=#{CREW_DEST_DIR} install-info || true"
      end

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
          LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          make DESTDIR=#{CREW_DEST_DIR} install-strip"

      # gcc-non-lib install
      gcc_arch = `gcc/xgcc -dumpmachine`.chomp
      gcc_version = version.split('-')[0]
      gcc_dir = "gcc/#{gcc_arch}/#{gcc_version}"
      gcc_libdir = "#{CREW_LIB_PREFIX}/#{gcc_dir}"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-driver install-cpp install-gcc-ar \
        c++.install-common install-headers install-plugin install-lto-wrapper"

      system "install -m755 -t #{CREW_DEST_PREFIX}/bin/ gcc/gcov"
      system "install -m755 -t #{CREW_DEST_PREFIX}/bin/ gcc/gcov-tool"
      @gcc_libdir_install = %w[cc1 cc1plus collect2 lto1]
      @gcc_libdir_install.each do |lib|
        system "install -m755 -t #{gcc_libdir}/ gcc/#{lib}"
      end

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libgcc DESTDIR=#{CREW_DEST_DIR} install"

      @libstdc_install = %w[src include libsupc++]
      @libstdc_install.each do |lib|
        system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      make -C #{CREW_TGT}/libstdc++-v3/#{lib} DESTDIR=#{CREW_DEST_DIR} install"
      end
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libstdc++-v3/python DESTDIR=#{CREW_DEST_DIR} install"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make DESTDIR=#{CREW_DEST_DIR} install-libcc1"

      # http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      # move a misplaced file
      # The installation stage puts some files used by gdb under the /usr/local/lib(64) directory.
      # This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      FileUtils.mv Dir.glob("#{CREW_DEST_LIB_PREFIX}/*gdb.py"),
                   "#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib/"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make DESTDIR=#{CREW_DEST_DIR} install-fixincludes"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-mkheaders"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C lto-plugin DESTDIR=#{CREW_DEST_DIR} install"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libitm DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libquadmath DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_sanincludeHEADERS || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer/asan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      # This failed on i686
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer/tsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      # This might fail on i686
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libsanitizer/lsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"

      # libiberty is installed from binutils
      # system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      #      LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      #      make -C libiberty DESTDIR=#{CREW_DEST_DIR} install"
      # install -m644 libiberty/pic/libiberty.a "#{CREW_DEST_PREFIX}/lib"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-man install-info"

      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C libcpp DESTDIR=#{CREW_DEST_DIR} install"
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C gcc DESTDIR=#{CREW_DEST_DIR} install-po"

      # install the libstdc++ man pages
      system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        make -C #{CREW_TGT}/libstdc++-v3/doc DESTDIR=#{CREW_DEST_DIR} doc-install-man"

      # byte-compile python libraries
      system "python -m compileall #{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}/"
      system "python -O -m compileall #{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}"

      # Make symbolic links
      FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}"
      Dir.chdir "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}" do
        system "find . -type f -maxdepth 1 -exec ln -sv #{gcc_libdir}/{} #{CREW_DEST_LIB_PREFIX}/{} \\;"
      end

      Dir.chdir "#{CREW_DEST_MAN_PREFIX}/man1" do
        Dir.glob("*-#{gcc_version}.1*").each do |f|
          @basefile = f.gsub("-#{gcc_version}", '')
          FileUtils.ln_sf f, @basefile
        end
      end

      # Only make links to unversioned in postinstall
      Dir.chdir "#{CREW_DEST_PREFIX}/bin/" do
        Dir.glob("#{gcc_arch}-*-#{gcc_version}").each do |f|
          # @basefile_nover=f.split(/-#{gcc_version}/, 2).first
          # puts "Symlinking #{f} to #{@basefile_nover}"
          # FileUtils.ln_sf f, @basefile_nover
          @basefile_noarch = f.split(/#{gcc_arch}-/, 2).last
          puts "Symlinking #{f} to #{@basefile_noarch}"
          FileUtils.ln_sf f, @basefile_noarch
        end
        # Dir.glob("*-#{gcc_version}").each do |f|
        # @basefile_nover=f.split(/-#{gcc_version}/, 2).first
        # FileUtils.ln_sf f, @basefile_nover
        # end
        # # many packages expect this symlink
        # FileUtils.ln_sf "gcc-#{gcc_version}", 'cc'
      end
      # libgomp.so conflicts with llvm
      @deletefiles = %W[#{CREW_DEST_LIB_PREFIX}/libgomp.so]
      @deletefiles.each do |f|
        FileUtils.rm f if File.exist?(f)
      end
    end
  end

  def self.postinstall
    # Only make links to unversioned in postinstall
    gcc_arch = `gcc-#{version} -dumpmachine`.chomp
    gcc_version = version.split('-')[0]
    gcc_dir = "gcc/#{gcc_arch}/#{gcc_version}"
    Dir.chdir "#{CREW_PREFIX}/bin/" do
      Dir.glob("#{gcc_arch}-*-#{gcc_version}").each do |f|
        @basefile_nover = f.split(/-#{gcc_version}/, 2).first
        puts "Symlinking #{f} to #{@basefile_nover}"
        FileUtils.ln_sf f, @basefile_nover
        # @basefile_noarch=f.split(/#{gcc_arch}-/, 2).last
        # puts "Symlinking #{f} to #{@basefile_noarch}"
        # FileUtils.ln_sf f, @basefile_noarch
        @basefile_noarch_nover = @basefile_nover.split(/#{gcc_arch}-/, 2).last
        puts "Symlinking #{f} to #{@basefile_noarch_nover}"
        FileUtils.ln_sf f, @basefile_noarch_nover
      end
      Dir.glob("*-#{gcc_version}").each do |f|
        @basefile_nover = f.split(/-#{gcc_version}/, 2).first
        puts "Symlinking #{f} to #{@basefile_nover}"
        FileUtils.ln_sf f, @basefile_nover
      end
      # many packages expect this symlink
      puts "Symlinking gcc-#{gcc_version} to cc"
      FileUtils.ln_sf "gcc-#{gcc_version}", 'cc'
    end
    # make sure current version of gcc LTO plugin for Gold linker is installed.
    FileUtils.mkdir_p "#{CREW_LIB_PREFIX}/bfd-plugins/"
    puts "Symlinking #{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so to #{CREW_LIB_PREFIX}/bfd-plugins/"
    FileUtils.ln_sf "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_LIB_PREFIX}/bfd-plugins/"
    # binutils makes a symlink here, but just in case it isn't there.
    unless CREW_LIB_PREFIX.to_s == "#{CREW_PREFIX}/lib"
      FileUtils.mkdir_p "#{CREW_PREFIX}/lib/bfd-plugins/"
      puts "Symlinking #{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so to #{CREW_PREFIX}/lib/bfd-plugins/"
      FileUtils.ln_sf "#{CREW_PREFIX}/libexec/#{gcc_dir}/liblto_plugin.so", "#{CREW_PREFIX}/lib/bfd-plugins/"
    end
  end
end
