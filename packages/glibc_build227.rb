require 'package'

class Glibc_build227 < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  binary_compression 'tar.xz'

  depends_on 'gawk' => :build
  depends_on 'filecmd' # L Fixes creating symlinks on a fresh install.
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build
  depends_on 'hashpipe' => :build

  no_env_options
  conflicts_ok

  @libc_version = LIBC_VERSION
  version '2.27-1'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
  source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc_build227/2.27-1_armv7l/glibc_build227-2.27-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc_build227/2.27-1_armv7l/glibc_build227-2.27-1-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc_build227/2.27-1_x86_64/glibc_build227-2.27-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '64b4b73e2096998fd1a0a0e7d18472ef977aebb2f1cad83d99c77e164cb6a1d6',
     armv7l: '64b4b73e2096998fd1a0a0e7d18472ef977aebb2f1cad83d99c77e164cb6a1d6',
     x86_64: '5fe94642dbbf900d22b715021c73ac1a601b81517f0da1e7413f0af8fbea7997'
  })

  def self.patch
      # Patch to avoid old ld issue on glibc 2.23 by using ld configure
      # portion from https://github.com/bminor/glibc/blob/master/configure
    @glibc_223_i686_patch = <<~'GLIBC_223_HEREDOC'
      --- a/configure	2021-12-22 11:42:36.689574968 -0500
      +++ b/configure	2021-12-22 11:58:43.052504544 -0500
      @@ -4434,7 +4434,143 @@ if test $ac_verc_fail = yes; then
         AS=: critic_missing="$critic_missing as"
       fi

      -for ac_prog in $LD
      +libc_cv_with_lld=no
      +case $($LD --version) in
      +  "GNU gold"*)
      +  # Accept gold 1.14 or higher
      +    for ac_prog in $LD
      +do
      +  # Extract the first word of "$ac_prog", so it can be a program name with args.
      +set dummy $ac_prog; ac_word=$2
      +{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
      +$as_echo_n "checking for $ac_word... " >&6; }
      +if ${ac_cv_prog_LD+:} false; then :
      +  $as_echo_n "(cached) " >&6
      +else
      +  if test -n "$LD"; then
      +  ac_cv_prog_LD="$LD" # Let the user override the test.
      +else
      +as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
      +for as_dir in $PATH
      +do
      +  IFS=$as_save_IFS
      +  test -z "$as_dir" && as_dir=.
      +    for ac_exec_ext in '' $ac_executable_extensions; do
      +  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
      +    ac_cv_prog_LD="$ac_prog"
      +    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_ext" >&5
      +    break 2
      +  fi
      +done
      +  done
      +IFS=$as_save_IFS
      +
      +fi
      +fi
      +LD=$ac_cv_prog_LD
      +if test -n "$LD"; then
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $LD" >&5
      +$as_echo "$LD" >&6; }
      +else
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
      +$as_echo "no" >&6; }
      +fi
      +
      +
      +  test -n "$LD" && break
      +done
      +
      +if test -z "$LD"; then
      +  ac_verc_fail=yes
      +else
      +  # Found it, now check the version.
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: checking version of $LD" >&5
      +$as_echo_n "checking version of $LD... " >&6; }
      +  ac_prog_version=`$LD --version 2>&1 | sed -n 's/^.*GNU gold.* \([0-9][0-9]*\.[0-9.]*\).*$/\1/p'`
      +  case $ac_prog_version in
      +    '') ac_prog_version="v. ?.??, bad"; ac_verc_fail=yes;;
      +    1.1[4-9]*|1.[2-9][0-9]*|1.1[0-9][0-9]*|[2-9].*|[1-9][0-9]*)
      +       ac_prog_version="$ac_prog_version, ok"; ac_verc_fail=no;;
      +    *) ac_prog_version="$ac_prog_version, bad"; ac_verc_fail=yes;;
      +
      +  esac
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_prog_version" >&5
      +$as_echo "$ac_prog_version" >&6; }
      +fi
      +if test $ac_verc_fail = yes; then
      +  LD=: critic_missing="$critic_missing GNU gold"
      +fi
      +
      +    ;;
      +  "LLD"*)
      +  # Accept LLD 13.0.0 or higher
      +    for ac_prog in $LD
      +do
      +  # Extract the first word of "$ac_prog", so it can be a program name with args.
      +set dummy $ac_prog; ac_word=$2
      +{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
      +$as_echo_n "checking for $ac_word... " >&6; }
      +if ${ac_cv_prog_LD+:} false; then :
      +  $as_echo_n "(cached) " >&6
      +else
      +  if test -n "$LD"; then
      +  ac_cv_prog_LD="$LD" # Let the user override the test.
      +else
      +as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
      +for as_dir in $PATH
      +do
      +  IFS=$as_save_IFS
      +  test -z "$as_dir" && as_dir=.
      +    for ac_exec_ext in '' $ac_executable_extensions; do
      +  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
      +    ac_cv_prog_LD="$ac_prog"
      +    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_ext" >&5
      +    break 2
      +  fi
      +done
      +  done
      +IFS=$as_save_IFS
      +
      +fi
      +fi
      +LD=$ac_cv_prog_LD
      +if test -n "$LD"; then
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $LD" >&5
      +$as_echo "$LD" >&6; }
      +else
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
      +$as_echo "no" >&6; }
      +fi
      +
      +
      +  test -n "$LD" && break
      +done
      +
      +if test -z "$LD"; then
      +  ac_verc_fail=yes
      +else
      +  # Found it, now check the version.
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: checking version of $LD" >&5
      +$as_echo_n "checking version of $LD... " >&6; }
      +  ac_prog_version=`$LD --version 2>&1 | sed -n 's/^.*LLD.* \([0-9][0-9]*\.[0-9.]*\).*$/\1/p'`
      +  case $ac_prog_version in
      +    '') ac_prog_version="v. ?.??, bad"; ac_verc_fail=yes;;
      +    1[3-9].*|[2-9][0-9].*)
      +       ac_prog_version="$ac_prog_version, ok"; ac_verc_fail=no;;
      +    *) ac_prog_version="$ac_prog_version, bad"; ac_verc_fail=yes;;
      +
      +  esac
      +  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_prog_version" >&5
      +$as_echo "$ac_prog_version" >&6; }
      +fi
      +if test $ac_verc_fail = yes; then
      +  LD=: critic_missing="$critic_missing LLD"
      +fi
      +
      +    libc_cv_with_lld=yes
      +    ;;
      +  *)
      +    for ac_prog in $LD
       do
         # Extract the first word of "$ac_prog", so it can be a program name with args.
       set dummy $ac_prog; ac_word=$2
      @@ -4485,7 +4621,7 @@ $as_echo_n "checking version of $LD... "
         ac_prog_version=`$LD --version 2>&1 | sed -n 's/^.*GNU ld.* \([0-9][0-9]*\.[0-9.]*\).*$/\1/p'`
         case $ac_prog_version in
           '') ac_prog_version="v. ?.??, bad"; ac_verc_fail=yes;;
      -    2.1[0-9][0-9]*|2.2[2-9]*|2.[3-9][0-9]*|[3-9].*|[1-9][0-9]*)
      +    2.1[0-9][0-9]*|2.2[5-9]*|2.[3-9][0-9]*|[3-9].*|[1-9][0-9]*)
              ac_prog_version="$ac_prog_version, ok"; ac_verc_fail=no;;
           *) ac_prog_version="$ac_prog_version, bad"; ac_verc_fail=yes;;

      @@ -4494,9 +4630,14 @@ $as_echo_n "checking version of $LD... "
       $as_echo "$ac_prog_version" >&6; }
       fi
       if test $ac_verc_fail = yes; then
      -  LD=: critic_missing="$critic_missing ld"
      +  LD=: critic_missing="$critic_missing GNU ld"
       fi

      +    ;;
      +esac
      +config_vars="$config_vars
      +with-lld = $libc_cv_with_lld"
      +

       # These programs are version sensitive.
    GLIBC_223_HEREDOC
    case ARCH
    when 'i686'
      File.write('glibc_223_i686.patch', @glibc_223_i686_patch)
      system 'patch -Np1 -i glibc_223_i686.patch'
    when 'armv7l', 'x86_64'
      @googlesource_branch = 'release-R91-13904.B'
      system "git clone --depth=1 -b  #{@googlesource_branch} https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay googlesource"
      Dir.glob("googlesource/sys-libs/glibc/files/local/glibc-2.27/glibc-#{@libc_version}*.patch").each do |patch|
        puts "patch -Np1 -i #{patch}" if @opt_verbose
        system "patch -Np1 -i #{patch} || (echo 'Retrying #{patch}' && patch -Np0 -i #{patch} || true)"
      end
      # Fix multiple definitions of __nss_*_database (bug 22918) in Glibc 2.27
      system 'curl -Ls "https://sourceware.org/git/?p=glibc.git;a=commitdiff_plain;h=eaf6753f8aac33a36deb98c1031d1bad7b593d2d;hp=4dc23804a220f917f400e2404bc4803cd60491c7" \
        hashpipe sha256 0c40630adf77292abb763362182158a87648e2c45904aebb5758b5ca38653ac9 | \
        patch -Np1 --binary || true'
    end
  end

  def self.build
    FileUtils.mkdir_p 'glibc_build'
    Dir.chdir 'glibc_build' do
      # gold linker does not work for glibc 2.23, and maybe others.
      FileUtils.mkdir_p 'binutils'
      @binutils = File.readlines(File.join(CREW_META_PATH, 'binutils.filelist'))
      @binutils.each do |bin|
        FileUtils.cp bin.chomp, "binutils/#{File.basename(bin.chomp)}" if bin['/bin/']
      end
      FileUtils.cp 'binutils/ld.bfd', 'binutils/ld'
      case ARCH
      when 'armv7l', 'aarch64'
        File.write('configparms', "slibdir=#{CREW_LIB_PREFIX}")
        # enable-obsolete-rpc will cause a conflict with libtirpc
        system "SYSROOT=''  CFLAGS='-O2 -fno-strict-aliasing -fno-stack-protector -march=armv7-a+fp' \
                LD=ld ../configure \
                #{CREW_OPTIONS} \
                --with-headers=#{CREW_PREFIX}/include \
                ac_cv_lib_cap_cap_init=no \
                --disable-sanity-checks \
                --disable-werror \
                --enable-bind-now \
                --enable-shared \
                --enable-static-pie \
                libc_cv_arm_tls=yes \
                libc_cv_asm_cfi_directives=yes \
                libc_cv_broken_visibility_attribute=no \
                libc_cv_c_cleanup=yes \
                libc_cv_forced_unwind=yes \
                libc_cv_gcc___thread=yes \
                libc_cv_hashstyle=no \
                --with-binutils=binutils \
                --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
                --without-cvs \
                --without-selinux"
      when 'x86_64'
        File.write('configparms', "slibdir=#{CREW_LIB_PREFIX}")
        system "CFLAGS='-O2 -pipe -fno-stack-protector' ../configure \
                 #{CREW_OPTIONS} \
                 --with-headers=#{CREW_PREFIX}/include \
                 --without-gd \
                 --disable-werror \
                 --disable-sanity-checks \
                 --enable-shared \
                 --with-binutils=binutils \
                 --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
                 --disable-multilib \
                 libc_cv_forced_unwind=yes \
                 libc_cv_ssp=no \
                 libc_cv_ssp_strong=no"
      end
      system "make PARALLELMFLAGS='-j #{CREW_NPROC}' || make || make PARALLELMFLAGS='-j 1'"
    end
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    system "sed 's,/usr/#{ARCH_LIB}/libc_nonshared.a,#{CREW_LIB_PREFIX}/libc_nonshared.a,g' /usr/#{ARCH_LIB}/libc.so > #{CREW_DEST_LIB_PREFIX}/libc.so"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    Dir.chdir 'glibc_build' do
      system 'touch', "#{CREW_DEST_PREFIX}/etc/ld.so.conf"
      case ARCH
      when 'aarch64', 'armv7l'
        system "make -j1 DESTDIR=#{CREW_DEST_DIR} install || true" # "sln elf/symlink.list" fails on armv7l
      when 'i686', 'x86_64'
        system "make -j1 DESTDIR=#{CREW_DEST_DIR} install"
      end
      Dir.chdir 'localedata' do
        system "mkdir -pv #{CREW_DEST_LIB_PREFIX}/locale"
        puts 'Install minimum set of locales'.lightblue

        # Assume old version of glibc is installed. -> use localedef.
        # If not installed, we can move following instruction to postinstall
        # Since glibc is a basic package, we prefer to provide pre-compiled package.
        # No compilcated detect logics required -> make it as simple as possible
        system "localedef --prefix=#{CREW_DEST_DIR} -i cs_CZ -f UTF-8 cs_CZ.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i de_DE -f ISO-8859-1 de_DE"
        system "localedef --prefix=#{CREW_DEST_DIR} -i de_DE@euro -f ISO-8859-15 de_DE@euro"
        system "localedef --prefix=#{CREW_DEST_DIR} -i de_DE -f UTF-8 de_DE.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i en_GB -f UTF-8 en_GB.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i en_HK -f ISO-8859-1 en_HK"
        system "localedef --prefix=#{CREW_DEST_DIR} -i en_PH -f ISO-8859-1 en_PH"
        system "localedef --prefix=#{CREW_DEST_DIR} -i en_US -f ISO-8859-1 en_US"
        system "localedef --prefix=#{CREW_DEST_DIR} -i en_US -f UTF-8 en_US.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i es_MX -f ISO-8859-1 es_MX"
        system "localedef --prefix=#{CREW_DEST_DIR} -i fa_IR -f UTF-8 fa_IR"
        system "localedef --prefix=#{CREW_DEST_DIR} -i fr_FR -f ISO-8859-1 fr_FR"
        system "localedef --prefix=#{CREW_DEST_DIR} -i fr_FR@euro -f ISO-8859-15 fr_FR@euro"
        system "localedef --prefix=#{CREW_DEST_DIR} -i fr_FR -f UTF-8 fr_FR.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i it_IT -f ISO-8859-1 it_IT"
        system "localedef --prefix=#{CREW_DEST_DIR} -i it_IT -f UTF-8 it_IT.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i ja_JP -f EUC-JP ja_JP"
        system "localedef --prefix=#{CREW_DEST_DIR} -i ru_RU -f KOI8-R ru_RU.KOI8-R"
        system "localedef --prefix=#{CREW_DEST_DIR} -i ru_RU -f UTF-8 ru_RU.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i tr_TR -f UTF-8 tr_TR.UTF-8"
        system "localedef --prefix=#{CREW_DEST_DIR} -i zh_CN -f GB18030 zh_CN.GB18030"
      end
    end
    Dir.chdir CREW_DEST_LIB_PREFIX do
      puts "System glibc version is #{LIBC_VERSION}.".lightblue
      puts 'Creating symlinks to system glibc version to prevent breakage.'.lightblue
      @crew_libc_version = @libc_version
      case ARCH
      when 'aarch64', 'armv7l'
        FileUtils.ln_sf "/lib/ld-#{@crew_libc_version}.so", 'ld-linux-armhf.so.3'
      when 'i686'
        FileUtils.ln_sf "/lib/ld-#{@crew_libc_version}.so", 'ld-linux-i686.so.2'
      when 'x86_64'
        FileUtils.ln_sf "/lib64/ld-#{@crew_libc_version}.so", 'ld-linux-x86-64.so.2'
      end
      @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                      libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                      libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                      libthread_db libresolv librlv librt libthread_db-1.0 libutil]
      @libraries -= ['libpthread'] if @crew_libc_version.to_f >= 2.35
      @libraries.each do |lib|
        # Reject entries which aren't libraries ending in .so, and which aren't files.
        Dir["/#{ARCH_LIB}/#{lib}.so*"].reject { |f| File.directory?(f) }.each do |f|
          @filetype = `file #{f}`.chomp
          if ['shared object', 'symbolic link'].any? { |type| @filetype.include?(type) }
            g = File.basename(f)
            FileUtils.ln_sf f.to_s, "#{CREW_DEST_LIB_PREFIX}/#{g}"
          end
        end
        # Reject entries which aren't libraries ending in .so, and which aren't files.
        # Reject text files such as libc.so because they points to files like
        # libc_nonshared.a, which are not provided by ChromeOS
        Dir["/usr/#{ARCH_LIB}/#{lib}.so*"].reject { |f| File.directory?(f) }.each do |f|
          @filetype = `file #{f}`.chomp
          puts "f: #{@filetype}" if @opt_verbose
          if ['shared object', 'symbolic link'].any? { |type| @filetype.include?(type) }
            g = File.basename(f)
            FileUtils.ln_sf f.to_s, "#{CREW_DEST_LIB_PREFIX}/#{g}"
          elsif @opt_verbose
            puts "#{f} excluded because #{@filetype}"
          end
        end
      end
    end
    # Only save libnsl.so.2, since libnsl.so.1 is provided by perl
    # For this to work, build on a M107 or newer container.
    FileUtils.cp File.realpath("#{CREW_DEST_LIB_PREFIX}/libnsl.so.1"), "#{CREW_DEST_LIB_PREFIX}/libnsl.so.2"
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libnsl.so"
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libnsl.so.1"

    # Remove libmount.so since it conflicts with the one from util_linux.
    FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/libmount.so*")
  end

  def self.check
    # Dir.chdir 'glibc_build' do
    #   system 'make -j1 check'
    # end
  end

  def self.postinstall
    if File.exist?("#{CREW_LIB_PREFIX}/libc.so.6")
      @crew_libcvertokens = `#{CREW_LIB_PREFIX}/libc.so.6`.lines.first.chomp.split(/\s/)
      @crew_libc_version = @crew_libcvertokens[@crew_libcvertokens.find_index('version') + 1].sub!(/[[:punct:]]?$/, '')
      puts "Package glibc version is #{@crew_libc_version}.".lightblue
    else
      @crew_libc_version = LIBC_VERSION
    end
    @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                    libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                    libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                    libthread_db libresolv librlv librt libthread_db-1.0 libutil]
    @libraries -= ['libpthread'] if @crew_libc_version.to_f >= 2.35
    Dir.chdir CREW_LIB_PREFIX do
      puts "System glibc version is #{@crew_libc_version}.".lightblue
      puts 'Creating symlinks to system glibc version to prevent breakage.'.lightblue
      case ARCH
      when 'aarch64', 'armv7l'
        FileUtils.ln_sf '/lib/ld-linux-armhf.so.3', 'ld-linux-armhf.so.3'
      when 'i686'
        FileUtils.ln_sf "/lib/ld-#{@crew_libc_version}.so", 'ld-linux-i686.so.2'
      when 'x86_64'
        FileUtils.ln_sf '/lib64/ld-linux-x86-64.so.2', 'ld-linux-x86-64.so.2'
      end
      @libraries.each do |lib|
        # Reject entries which aren't libraries ending in .so, and which aren't files.
        Dir["/#{ARCH_LIB}/#{lib}.so*"].reject { |f| File.directory?(f) }.each do |f|
          @filetype = `file #{f}`.chomp
          if ['shared object', 'symbolic link'].any? { |type| @filetype.include?(type) }
            g = File.basename(f)
            FileUtils.ln_sf f.to_s, "#{CREW_LIB_PREFIX}/#{g}"
          end
        end
        # Reject entries which aren't libraries ending in .so, and which aren't files.
        # Reject text files such as libc.so because they points to files like
        # libc_nonshared.a, which are not provided by ChromeOS
        Dir["/usr/#{ARCH_LIB}/#{lib}.so*"].reject { |f| File.directory?(f) }.each do |f|
          @filetype = `file #{f}`.chomp
          puts "f: #{@filetype}" if @opt_verbose
          if ['shared object', 'symbolic link'].any? { |type| @filetype.include?(type) }
            g = File.basename(f)
            FileUtils.ln_sf f.to_s, "#{CREW_LIB_PREFIX}/#{g}"
          elsif @opt_verbose
            puts "#{f} excluded because #{@filetype}"
          end
        end
      end
    end
  end
end
