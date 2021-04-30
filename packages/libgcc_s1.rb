require 'package'

class Libgcc_s1 < Package
  description 'GCC support library'
  homepage 'https://www.gnu.org/software/gcc/'
  version '11.1.0'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://sourceware.org/pub/gcc/releases/gcc-11.1.0/gcc-11.1.0.tar.xz'
  source_sha256 '4c4a6fb8a8396059241c2e674b85b351c26a5d678274007f076957afa1cc9ddf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcc_s1/11.1.0_armv7l/libgcc_s1-11.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcc_s1/11.1.0_armv7l/libgcc_s1-11.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcc_s1/11.1.0_i686/libgcc_s1-11.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgcc_s1/11.1.0_x86_64/libgcc_s1-11.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9f18830d0504a358ddc9f8600b96004bf6e288c06a08973ae0339cb10d53ba85',
     armv7l: '9f18830d0504a358ddc9f8600b96004bf6e288c06a08973ae0339cb10d53ba85',
       i686: '03c4ee0d5679eb6a14e2fa5ffc544f08ca1c6394b281c11aaf17227d9f89009b',
     x86_64: '7342a91c30aa8b5b6af73acded14efd9954d5fb8b7bf96a1b0ac07f86d278292'
  })

  #depends_on 'ccache' => :build
  #depends_on 'dejagnu' => :build # for test
  #depends_on 'hashpipe' => :build
  depends_on 'glibc' # R
  #depends_on 'gmp' # R
  #depends_on 'isl' # R
  #depends_on 'mpc' # R
  #depends_on 'mpfr' # R
  #depends_on 'libssp' # L

  #@gcc_global_opts = '--disable-bootstrap \
  #--disable-libmpx \
  #--disable-libssp \
  #--disable-multilib \
  #--disable-werror \
  #--enable-cet=auto \
  #--enable-checking=release \
  #--enable-clocale=gnu \
  #--enable-default-pie \
  #--enable-default-ssp \
  #--enable-gnu-indirect-function \
  #--enable-gnu-unique-object \
  #--enable-host-shared \
  #--enable-lto \
  #--enable-plugin \
  #--enable-shared \
  #--enable-symvers \
  #--enable-static \
  #--enable-threads=posix \
  #--with-gcc-major-version-only \
  #--with-gmp \
  #--with-isl \
  #--with-mpc \
  #--with-mpfr \
  #--with-pic \
  #--with-system-libunwind \
  #--with-system-zlib'

  #@cflags = '-fPIC -pipe'
  #@cxxflags = '-fPIC -pipe'
  #@languages = 'c,c++,jit,objc,fortran,go'
  #case ARCH
  #when 'armv7l', 'aarch64'
    #@archflags = '--with-arch=armv7-a --with-float=hard --with-fpu=neon --with-tune=cortex-a15'
  #when 'x86_64'
    #@archflags = '--with-arch-64=x86-64'
  #when 'i686'
    #@archflags = '--with-arch-32=i686'
  #end


  #def self.patch
    ## This fixes a PATH_MAX undefined error which breaks libsanitizer
    ## "libsanitizer/asan/asan_linux.cpp:217:21: error: ‘PATH_MAX’ was not declared in this scope"
    ## This is defined in https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-5.4/include/uapi/linux/limits.h
    ## and is defined as per suggested method here: https://github.com/ZefengWang/cross-tool-chain-build
    ## The following is due to sed not passing newlines right.
    #system "grep  -q 4096 libsanitizer/asan/asan_linux.cpp || (sed -i '77a #endif' libsanitizer/asan/asan_linux.cpp &&
    #sed -i '77a #define PATH_MAX 4096' libsanitizer/asan/asan_linux.cpp &&
    #sed -i '77a #ifndef PATH_MAX' libsanitizer/asan/asan_linux.cpp)"
  #end

  #def self.build
    ## Set ccache sloppiness as per
    ## https://wiki.archlinux.org/index.php/Ccache#Sloppiness
    #system 'ccache --set-config=sloppiness=file_macro,locale,time_macros'
    ## Prefix ccache to path.
    #@path = "#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin"

    ## Install prereqs using the standard gcc method so they can be
    ## linked statically.
    ## system './contrib/download_prerequisites'

    ### Install newer version of gmp
    ## gmp_url = "https://gmplib.org/download/gmp/gmp-#{@gmp_ver}.tar.lz"
    ## gmp_sha256 = '2c7f4f0d370801b2849c48c9ef3f59553b5f1d3791d070cffb04599f9fc67b41'
    ## system "curl -Ls #{gmp_url} | hashpipe sha256 #{gmp_sha256} | tar --lzip -x"
    ## system "ln -sf ../gmp-#{@gmp_ver} gmp"

    ### Install newer version of isl
    ## isl_url = "http://isl.gforge.inria.fr/isl-#{@isl_ver}.tar.bz2"
    ## isl_sha256 = 'c58922c14ae7d0791a77932f377840890f19bc486b653fa64eba7f1026fb214d'
    ## system "curl -Ls #{isl_url} | hashpipe sha256 #{isl_sha256} | tar xj"
    ## system "ln -sf ../isl-#{@isl_ver} isl"

    ### Install newer version of mpc
    ## mpc_url = "https://ftp.gnu.org/gnu/mpc/mpc-#{@mpc_ver}.tar.gz"
    ## mpc_sha256 = '17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459'
    ## system "curl -Ls #{mpc_url} | hashpipe sha256 #{mpc_sha256} | tar xz"
    ## system "ln -sf ../mpc-#{@mpc_ver} mpc"

    ### Install newer version of mpfr
    ## mpfr_url = "https://www.mpfr.org/mpfr-current/mpfr-#{@mpfr_ver}.tar.xz"
    ## mpfr_sha256 = '0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f'
    ## system "curl -Ls #{mpfr_url} | hashpipe sha256 #{mpfr_sha256} | tar xJ"
    ## Dir.chdir "mpfr-#{@mpfr_ver}" do
    ##  system 'curl -Ls "https://gforge.inria.fr/scm/viewvc.php/mpfr/misc/www/mpfr-4.1.0/allpatches?revision=14491&view=co" | \
    ##    hashpipe sha256 dfa7d8a14ec7cb3b344cb81cfd7bd7e22aba62379941cc9110759f11172ac013 | patch -NZp1 --binary'
    ## end
    ## system "ln -sf ../mpfr-#{@mpfr_ver} mpfr"

    #gcc_version = version.split('-')[0]

    #FileUtils.mkdir_p 'objdir/gcc/.deps'

    #Dir.chdir('objdir') do
      #system "env NM=gcc-nm AR=gcc-ar RANLIB=gcc-ranlib \
        #CFLAGS='#{@cflags}' CXXFLAGS='#{@cxxflags}' \
        #LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #../configure #{CREW_OPTIONS} \
        ##{@gcc_global_opts} \
        ##{@archflags} \
        #--enable-languages=#{@languages} \
        #--program-suffix=-#{gcc_version}"
      ## LIBRARY_PATH=#{CREW_LIB_PREFIX} needed for x86_64 to avoid:
      ## /usr/local/bin/ld: cannot find crti.o: No such file or directory
      ## /usr/local/bin/ld: cannot find /usr/lib64/libc_nonshared.a
      #system "env PATH=#{@path} \
        #LIBRARY_PATH=#{CREW_LIB_PREFIX} \
        #make"
    #end
  #end

  ## preserve for check, skip check for current version
  #def self.check
    ## Dir.chdir('objdir') do
    ##  system "make -k check -j#{CREW_NPROC} || true"
    ##  system '../contrib/test_summary'
    ## end
  #end

  #def self.install
    #Dir.chdir('objdir') do
      #FileUtils.mkdir_p "#{CREW_DEST_DIR}/tmp"
      ## gcc-libs install
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          #make -C #{CREW_TGT}/libgcc DESTDIR=#{CREW_DEST_DIR} install-shared"

      #@gcc_libs = %w[libatomic libgfortran libgo libgomp libitm
                     #libquadmath libsanitizer/asan libsanitizer/lsan libsanitizer/ubsan
                     #libsanitizer/tsan libstdc++-v3/src libvtv]
      #@gcc_libs.each do |lib|
        #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          #make -C #{CREW_TGT}/#{lib} \
          #DESTDIR=#{CREW_DEST_DIR} install-toolexeclibLTLIBRARIES || true"
      #end

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libobjc DESTDIR=#{CREW_DEST_DIR} install-libs || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libstdc++-v3/po DESTDIR=#{CREW_DEST_DIR} install || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libphobos DESTDIR=#{CREW_DEST_DIR} install || true"

      #@gcc_libs_info = %w[libgomp libitm libquadmath]
      #@gcc_libs_info.each do |lib|
        #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          #make -C #{CREW_TGT}/#{lib} DESTDIR=#{CREW_DEST_DIR} install-info || true"
      #end

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
          #make DESTDIR=#{CREW_DEST_DIR} install-strip"

      ## gcc-non-lib install
      #gcc_arch = `gcc/xgcc -dumpmachine`.chomp
      #gcc_version = version.split('-')[0]
      #gcc_dir = "gcc/#{gcc_arch}/#{gcc_version}"
      #gcc_libdir = "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C gcc DESTDIR=#{CREW_DEST_DIR} install-driver install-cpp install-gcc-ar \
        #c++.install-common install-headers install-plugin install-lto-wrapper"

      #@gcov_install = %w[gcov gcov-tool]
      #@gcov_install.each do |gcov_bin|
        #FileUtils.install "gcc/#{gcov_bin}", "tmp/#{CREW_DEST_PREFIX}/bin/#{gcov_bin}-#{gcc_version}", mode: 0o755
      #end

      #FileUtils.mkdir_p gcc_libdir
      #@gcc_libdir_install = %w[cc1 cc1plus collect2 lto1]
      #@gcc_libdir_install.each do |lib|
        #FileUtils.install "gcc/#{lib}", "#{gcc_libdir}/", mode: 0o755
      #end

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libgcc DESTDIR=#{CREW_DEST_DIR} install"

      #@libstdc_install = %w[src include libsupc++]
      #@libstdc_install.each do |lib|
        #system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      #LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      #make -C #{CREW_TGT}/libstdc++-v3/#{lib} DESTDIR=#{CREW_DEST_DIR} install"
      #end
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libstdc++-v3/python DESTDIR=#{CREW_DEST_DIR} install"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make DESTDIR=#{CREW_DEST_DIR} install-libcc1"

      ## http://www.linuxfromscratch.org/lfs/view/development/chapter06/gcc.html#contents-gcc
      ## move a misplaced file
      ## The installation stage puts some files used by gdb under the /usr/local/lib(64) directory.
      ## This generates spurious error messages when performing ldconfig. This command moves the files to another location.
      #FileUtils.mkdir_p "tmp/#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib"
      #FileUtils.mv Dir.glob("#{CREW_DEST_LIB_PREFIX}/*gdb.py"),
                   #"tmp/#{CREW_DEST_PREFIX}/share/gdb/auto-load/usr/lib/"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make DESTDIR=#{CREW_DEST_DIR} install-fixincludes"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C gcc DESTDIR=#{CREW_DEST_DIR} install-mkheaders"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C lto-plugin DESTDIR=#{CREW_DEST_DIR} install"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libgomp DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libitm DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libquadmath DESTDIR=#{CREW_DEST_DIR} install-nodist_libsubincludeHEADERS || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_sanincludeHEADERS || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libsanitizer DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libsanitizer/asan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      ## This failed on i686
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libsanitizer/tsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"
      ## This might fail on i686
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libsanitizer/lsan DESTDIR=#{CREW_DEST_DIR} install-nodist_toolexeclibHEADERS || true"

      ## libiberty is installed from binutils
      ## system "env LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
      ##      LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
      ##      make -C libiberty DESTDIR=#{CREW_DEST_DIR} install"
      ## install -m644 libiberty/pic/libiberty.a "tmp/#{CREW_DEST_PREFIX}/lib"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C gcc DESTDIR=#{CREW_DEST_DIR} install-man install-info"

      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C libcpp DESTDIR=#{CREW_DEST_DIR} install"
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C gcc DESTDIR=#{CREW_DEST_DIR} install-po"

      ## install the libstdc++ man pages
      #system "env LIBRARY_PATH=#{CREW_LIB_PREFIX} PATH=#{@path} \
        #make -C #{CREW_TGT}/libstdc++-v3/doc DESTDIR=#{CREW_DEST_DIR} doc-install-man"

      ## byte-compile python libraries
      #system "python -m compileall tmp/#{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}/"
      #system "python -O -m compileall tmp/#{CREW_DEST_PREFIX}/share/gcc-#{@gcc_version}"

      ## Make symbolic links
      #FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}"
      #Dir.chdir "#{CREW_DEST_LIB_PREFIX}/#{gcc_dir}" do
        #system "find . -type f -maxdepth 1 -exec ln -sv #{gcc_libdir}/{} #{CREW_DEST_LIB_PREFIX}/{} \\;"
      #end

      #Dir.chdir "#{CREW_DEST_MAN_PREFIX}/man1" do
        #Dir.glob("*-#{gcc_version}.1*").each do |f|
          #@basefile = f.gsub("-#{gcc_version}", '')
          #FileUtils.ln_sf f, @basefile
        #end
      #end

      ## Only make links to unversioned in postinstall
      #Dir.chdir "tmp/#{CREW_DEST_PREFIX}/bin/" do
        #Dir.glob("#{gcc_arch}-*-#{gcc_version}").each do |f|
          ## @basefile_nover=f.split(/-#{gcc_version}/, 2).first
          ## puts "Symlinking #{f} to #{@basefile_nover}"
          ## FileUtils.ln_sf f, @basefile_nover
          #@basefile_noarch = f.split(/#{gcc_arch}-/, 2).last
          #puts "Symlinking #{f} to #{@basefile_noarch}"
          #FileUtils.ln_sf f, @basefile_noarch
        #end
        ## Dir.glob("*-#{gcc_version}").each do |f|
        ## @basefile_nover=f.split(/-#{gcc_version}/, 2).first
        ## FileUtils.ln_sf f, @basefile_nover
        ## end
        ## # many packages expect this symlink
        ## FileUtils.ln_sf "gcc-#{gcc_version}", 'cc'
      #end
      ## libgomp.so conflicts with llvm
      #@deletefiles = %W[#{CREW_DEST_LIB_PREFIX}/libgomp.so]
      #@deletefiles.each do |f|
        #FileUtils.rm f if File.exist?(f)
      #end
    #end
  #end

  def self.postinstall
  # built using this:
    ##!/bin/bash -e
    ## Usage: ./extracttar original_tar_archive new_tar_archive files_or_pattern_to_extract
    ## One may pass the --wildcards flag if necessary.
    #origfile=$1
    #newfile=$2
    #startdir="$(pwd)"
    #extract="${@:3}"
    #sanitized_extract=
    #for i in $extract
    #do
    #[[ $i == /* ]] && sanitized_extract+=" ${i#/} "
    #done

    #tmpdir=$(mktemp -d)
    #mkdir -p $tmpdir/extract_dir
    #cd $tmpdir/extract_dir && tar afvx "$startdir"/$origfile $(echo "$sanitized_extract")
    ## create file list
    #find . -type f > ../filelist
    #find . -type l >> ../filelist
    #cut -c2- ../filelist > filelist
    ## create directory list
    #find . -type d > ../dlist
    #cut -c2- ../dlist > dlistcut
    #tail -n +2 dlistcut > dlist
    ## Create new archive
    #[[ -e "$startdir"/${newfile} ]] && mv  "$startdir"/${newfile} "$startdir"/${newfile}.old
    #tar -c * --owner=chronos:1000 --group=chronos:1000 --use-compress-program='xz -9 -T 0' -f "$startdir"/${newfile}
    #cd "$startdir"
    #rm -rf $tmpdir
    #sha256sum ${newfile} > ${newfile}.sha256
  # extracttar gcc11-11.1.0-chromeos-x86_64.tar.xz libgcc_s1-11.1.0-chromeos-x86_64.tar.xz /usr/local/lib64/libgcc_s.so.1
  end
end
