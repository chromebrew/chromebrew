require 'package'

class Glibc_build < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'

  depends_on 'gawk' => :build
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build
  depends_on 'hashpipe' => :build

  no_env_options
  conflicts_ok

  @libc_version = LIBC_VERSION
  # Uncomment following line to build a version of glibc different
  # from the one ChromeOS ships with.
  # @libc_version = '2.35'
  if @libc_version == '2.23'
    version '2.23-6'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.23.tar.xz'
    source_sha256 '94efeb00e4603c8546209cefb3e1a50a5315c86fa9b078b6fad758e187ce13e9'

    binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.23-6_i686/glibc-2.23-6-chromeos-i686.tar.zst'
    })
    binary_sha256({
      i686: 'f40aa662009999330bd1be1feb6c64efbe663a7a308973dc7c5a2b41c1faaf6b'
    })
  elsif @libc_version == '2.27'
    version '2.27-1'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
    source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.27_armv7l/glibc-2.27-chromeos-armv7l.tar.xz',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.27_armv7l/glibc-2.27-chromeos-armv7l.tar.xz',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.27_x86_64/glibc-2.27-chromeos-x86_64.tar.xz'
    })
    binary_sha256({
      aarch64: '64b4b73e2096998fd1a0a0e7d18472ef977aebb2f1cad83d99c77e164cb6a1d6',
       armv7l: '64b4b73e2096998fd1a0a0e7d18472ef977aebb2f1cad83d99c77e164cb6a1d6',
       x86_64: '5fe94642dbbf900d22b715021c73ac1a601b81517f0da1e7413f0af8fbea7997'
    })
  elsif @libc_version == '2.32' # All architectures with updates past M92.
    version '2.32-3'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.32.tar.xz'
    source_sha256 '1627ea54f5a1a8467032563393e0901077626dc66f37f10ee6363bb722222836'

    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32-2_armv7l/glibc-2.32-2-chromeos-armv7l.tpxz',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32-2_armv7l/glibc-2.32-2-chromeos-armv7l.tpxz',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32-2_x86_64/glibc-2.32-2-chromeos-x86_64.tpxz'
    })
    binary_sha256({
      aarch64: 'ea89e4f2bcd1ec397108d17b834199e04652316f870e1ec0f6389db1ad864e6b',
       armv7l: 'ea89e4f2bcd1ec397108d17b834199e04652316f870e1ec0f6389db1ad864e6b',
       x86_64: '3e3eaa6551492ef0f1bc28600102503b721b19d0ee7396c4301771df402ea355'
    })
  elsif @libc_version == '2.33' # All architectures with updates past M97.
    version '2.33-3'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.33.tar.xz'
    source_sha256 '2e2556000e105dbd57f0b6b2a32ff2cf173bde4f0d85dffccfd8b7e51a0677ff'

    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.33-3_armv7l/glibc-2.33-3-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.33-3_armv7l/glibc-2.33-3-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.33-3_x86_64/glibc-2.33-3-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: '11a3e7ba5eec18c325afa80bc869b4f8cc1fcbfef78ddf25e1b1e278679203a4',
       armv7l: '11a3e7ba5eec18c325afa80bc869b4f8cc1fcbfef78ddf25e1b1e278679203a4',
       x86_64: '3edde53b5ab8b577604b127c141042f4572b8972b7081abcda2e86778d1974a9'
    })
  elsif @libc_version.to_f >= 2.35 # All architectures with updates past M108.
    version '2.35-1'
    # Use current glibc 2.35 stable branch commit, which avoids
    # compilation failures, from https://github.com/bminor/glibc/tree/release/2.35/master
    source_url 'https://github.com/bminor/glibc/archive/757d9a6306cee9e96d7a4d1d11c8d69763c6eecf.zip'
    source_sha256 '75d6586a89a8c03b434ef7fa1b4b02b007287fc9a6b8148a84e97d6ed039872d'
    # source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.35.tar.xz'
    # source_sha256 '5123732f6b67ccd319305efd399971d58592122bcc2a6518a1bd2510dd0cf52e'

    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.35-1_armv7l/glibc-2.35-1-chromeos-armv7l.tar.zst',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.35-1_armv7l/glibc-2.35-1-chromeos-armv7l.tar.zst',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.35-1_x86_64/glibc-2.35-1-chromeos-x86_64.tar.zst'
    })
    binary_sha256({
      aarch64: '928b60200126cb0d69401bc5124a9a4e7b2294b54a1046c6f88caa45d7be32b9',
       armv7l: '928b60200126cb0d69401bc5124a9a4e7b2294b54a1046c6f88caa45d7be32b9',
       x86_64: 'e7977a6ad811776fbb8c3d54e11e408a5f9ffeee8b3d8bb666255695b3fc20d6'
    })
  end

  def self.patch
    case @libc_version
    when '2.23', '2.27'
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
    when '2.32'
      FileUtils.mkdir 'fedora'
      # Patch to enable build-local-archive
      system 'curl -Ls https://src.fedoraproject.org/rpms/glibc/raw/f30/f/glibc-fedora-locarchive.patch | \
      hashpipe sha256 0acccf57d8c6e7de82871c61ccb845f7a1ae13ae1fbc65995d347de8367c7bb1 | \
      patch -Np1 --binary'
      system 'curl -Ls https://src.fedoraproject.org/rpms/glibc/raw/f30/f/build-locale-archive.c | \
      hashpipe sha256 6834e8b8f2a987bf8adfd265c0e01665f102c7115db94b99ec36376b68e9d3fa > fedora/build-locale-archive.c'
      system "sed -i 's,/lib/locale,/lib#{CREW_LIB_SUFFIX}/locale,g' fedora/build-locale-archive.c"
      system "sed -i 's,/usr/sbin/tzdata-update,/bin/true,g' fedora/build-locale-archive.c"
      system "sed -i 's,verbose,locale_verbose,g' fedora/build-locale-archive.c"
      system "sed -i 's,be_quiet,locale_be_quiet,g' fedora/build-locale-archive.c"
      FileUtils.mkdir_p 'gentoopatches'
      system 'curl -Ls https://dev.gentoo.org/~dilfridge/distfiles/glibc-2.32-patches-8.tar.xz | \
        hashpipe sha256 6653f1d0aadad10bd288f3bae274bd4e0a013d47f09ce78199fb5989b2d8fd9b | \
        tar -xJf - -C gentoopatches'
      Dir.glob('gentoopatches/patches/*.patch').each do |patch|
        puts "patch -Np1 < #{patch}" if @opt_verbose
        system "patch -Np1 < #{patch}"
      end
      @googlesource_branch = 'release-R96-14268.B'
      system "git clone --depth=1 -b  #{@googlesource_branch} https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay googlesource"
      Dir.glob('googlesource/sys-libs/glibc/files/local/glibc-2.32/*.patch').each do |patch|
        puts "patch -Np1 < #{patch}" if @opt_verbose
        system "patch -Np1 < #{patch}"
      end
    when '2.33'
      FileUtils.mkdir 'fedora'
      # Patch to enable build-local-archive
      system 'curl -Ls https://src.fedoraproject.org/rpms/glibc/raw/f30/f/glibc-fedora-locarchive.patch | \
      hashpipe sha256 0acccf57d8c6e7de82871c61ccb845f7a1ae13ae1fbc65995d347de8367c7bb1 | \
      patch -Np1 --binary'
      system 'curl -Ls https://src.fedoraproject.org/rpms/glibc/raw/f30/f/build-locale-archive.c | \
      hashpipe sha256 6834e8b8f2a987bf8adfd265c0e01665f102c7115db94b99ec36376b68e9d3fa > fedora/build-locale-archive.c'
      system "sed -i 's,/lib/locale,/lib#{CREW_LIB_SUFFIX}/locale,g' fedora/build-locale-archive.c"
      system "sed -i 's,/usr/sbin/tzdata-update,/bin/true,g' fedora/build-locale-archive.c"
      system "sed -i 's,verbose,locale_verbose,g' fedora/build-locale-archive.c"
      system "sed -i 's,be_quiet,locale_be_quiet,g' fedora/build-locale-archive.c"
      FileUtils.mkdir_p 'gentoopatches'
      system 'curl -Ls https://dev.gentoo.org/~dilfridge/distfiles/glibc-2.33-patches-6.tar.xz | \
        hashpipe sha256 29c2e4036c2b33b830a9588055c63fde5dd5255bcfd5fad2fc92f3bbd27456c1 | \
        tar -xJf - -C gentoopatches'
      Dir.glob('gentoopatches/patches/*.patch').each do |patch|
        puts "patch -Np1 -i #{patch} || true" if @opt_verbose
        system "patch -Np1 -i #{patch} || true"
      end
      @googlesource_branch = 'release-R99-14469.B'
      system "git clone --depth=1 -b  #{@googlesource_branch} https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay googlesource"
      Dir.glob('googlesource/sys-libs/glibc/files/local/glibc-2.33/*.patch').each do |patch|
        puts "patch -Np1 < #{patch} || true" if @opt_verbose
        system "patch -Np1 < #{patch} || true"
      end
    when '2.35'
      FileUtils.mkdir 'fedora'
      # Patch to enable build-local-archive
      system 'curl -Ls https://src.fedoraproject.org/rpms/glibc/raw/f30/f/glibc-fedora-locarchive.patch | \
      hashpipe sha256 0acccf57d8c6e7de82871c61ccb845f7a1ae13ae1fbc65995d347de8367c7bb1 | \
      patch -Np1 --binary'
      system 'curl -Ls https://src.fedoraproject.org/rpms/glibc/raw/f30/f/build-locale-archive.c | \
      hashpipe sha256 6834e8b8f2a987bf8adfd265c0e01665f102c7115db94b99ec36376b68e9d3fa > fedora/build-locale-archive.c'
      system "sed -i 's,/lib/locale,/lib#{CREW_LIB_SUFFIX}/locale,g' fedora/build-locale-archive.c"
      system "sed -i 's,/usr/sbin/tzdata-update,/bin/true,g' fedora/build-locale-archive.c"
      system "sed -i 's,verbose,locale_verbose,g' fedora/build-locale-archive.c"
      system "sed -i 's,be_quiet,locale_be_quiet,g' fedora/build-locale-archive.c"
      @googlesource_branch = 'release-R109-15236.B'
      system "git clone --depth=1 -b  #{@googlesource_branch} https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay googlesource"
      # Remove conflicting patches.
      FileUtils.rm 'googlesource/sys-libs/glibc/files/local/glibc-2.35/0005-Add-dlopen_with_offset-to-glibc.patch'
      FileUtils.rm 'googlesource/sys-libs/glibc/files/local/glibc-2.35/0006-glibc-add-clang-style-FORTIFY.patch'
      Dir.glob('googlesource/sys-libs/glibc/files/local/glibc-2.35/*.patch').each do |patch|
        puts "patch -Np1 < #{patch} || true" if @opt_verbose
        system "patch -Np1 -F 10 -i #{patch} || true"
      end
    end
  end

  def self.build
    FileUtils.mkdir_p 'glibc_build'
    Dir.chdir 'glibc_build' do
      # gold linker does not work for glibc 2.23, and maybe others.
      FileUtils.mkdir_p 'binutils'
      @binutils = File.readlines("#{CREW_META_PATH}binutils.filelist")
      @binutils.each do |bin|
        FileUtils.cp bin.chomp, "binutils/#{File.basename(bin.chomp)}" if bin['/bin/']
      end
      FileUtils.cp 'binutils/ld.bfd', 'binutils/ld'
      case @libc_version
      when '2.23' # This is only for glibc 2.23
        system "CFLAGS='-O2 -pipe -fno-stack-protector' ../configure \
                 #{CREW_OPTIONS} \
                 --with-headers=#{CREW_PREFIX}/include \
                 --without-gd \
                 --disable-werror \
                 --disable-sanity-checks \
                 --enable-shared \
                 --disable-multilib \
                 --with-binutils=binutils \
                 --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
                 libc_cv_forced_unwind=yes \
                 libc_cv_ssp=no \
                 libc_cv_ssp_strong=no"
      when '2.27'
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
      end
      if @libc_version.to_f >= 2.32
        # Optimization flags from https://github.com/InBetweenNames/gentooLTO
        case ARCH
        when 'armv7l', 'aarch64'
          system "CFLAGS='-pipe -O2 -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
            LD=ld ../configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --with-headers=#{CREW_PREFIX}/include \
            --without-gd \
            ac_cv_header_cpuid_h=yes \
            ac_cv_lib_audit_audit_log_user_avc_message=no \
            ac_cv_lib_cap_cap_init=no \
            --disable-profile \
            --disable-sanity-checks \
            --disable-werror \
            --enable-bind-now \
            --enable-hacker-mode \
            --enable-kernel=4.14 \
            --enable-shared \
            libc_cv_386_tls=yes \
            libc_cv_arm_tls=yes \
            libc_cv_asm_cfi_directives=yes \
            libc_cv_broken_visibility_attribute=no \
            libc_cv_c_cleanup=yes \
            libc_cv_forced_unwind=yes \
            libc_cv_gcc___thread=yes \
            libc_cv_hashstyle=no \
            libc_cv_mlong_double_128ibm=yes \
            libc_cv_mlong_double_128=yes \
            libc_cv_predef_fortify_source=no \
            libc_cv_visibility_attribute=yes \
            libc_cv_x86_64_tls=yes \
            libc_cv_z_combreloc=yes \
            libc_cv_z_execstack=yes \
            libc_cv_z_initfirst=yes \
            libc_cv_z_nodelete=yes \
            libc_cv_z_nodlopen=yes \
            libc_cv_z_relro=yes \
            --with-binutils=binutils \
            --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
            --without-cvs \
            --without-selinux \
            "
          # install-symbolic-link segfaults on armv7l, but we're deleting
          # the libraries anyways, so it doesn't matter.
          system "sed -i 's,install-symbolic-link,/bin/true,g' ../Makefile"
          system "sed -i 's,symbolic-link-prog := $(elf-objpfx)sln,symbolic-link-prog := /bin/true,g' ../Makerules"
        when 'x86_64'
          File.write('configparms', "slibdir=#{CREW_LIB_PREFIX}", mode: 'a+')
          system "CFLAGS='-pipe -O2 -fipa-pta -fno-semantic-interposition -falign-functions=32 -fdevirtualize-at-ltrans' \
            LD=ld ../configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --with-headers=#{CREW_PREFIX}/include \
            ac_cv_header_cpuid_h=yes \
            ac_cv_lib_audit_audit_log_user_avc_message=no \
            ac_cv_lib_cap_cap_init=no \
            --disable-profile \
            --disable-sanity-checks \
            --disable-werror \
            --enable-bind-now \
            --enable-cet \
            --enable-hacker-mode \
            --enable-kernel=4.14 \
            --enable-shared \
            libc_cv_386_tls=yes \
            libc_cv_arm_tls=yes \
            libc_cv_asm_cfi_directives=yes \
            libc_cv_broken_visibility_attribute=no \
            libc_cv_c_cleanup=yes \
            libc_cv_forced_unwind=yes \
            libc_cv_gcc___thread=yes \
            libc_cv_hashstyle=no \
            libc_cv_mlong_double_128ibm=yes \
            libc_cv_mlong_double_128=yes \
            libc_cv_predef_fortify_source=no \
            libc_cv_visibility_attribute=yes \
            libc_cv_x86_64_tls=yes \
            libc_cv_z_combreloc=yes \
            libc_cv_z_execstack=yes \
            libc_cv_z_initfirst=yes \
            libc_cv_z_nodelete=yes \
            libc_cv_z_nodlopen=yes \
            libc_cv_z_relro=yes \
            --with-binutils=binutils \
            --with-bugurl=https://github.com/chromebrew/chromebrew/issues/new \
            --without-cvs \
            --without-gd \
            --without-selinux \
            "
        end
      end
      system "make PARALLELMFLAGS='-j #{CREW_NPROC}' || make || make PARALLELMFLAGS='-j 1'"
      if @libc_version.to_f >= 2.32
        system "gcc -Os -g -static -o build-locale-archive ../fedora/build-locale-archive.c \
          ../glibc_build/locale/locarchive.o \
          ../glibc_build/locale/md5.o \
          ../glibc_build/locale/record-status.o \
          -I. -DDATADIR=\\\"#{CREW_PREFIX}/share\\\" -DPREFIX=\\\"#{CREW_PREFIX}\\\" \
          -L../glibc_build \
          -B../glibc_build/csu/ -lc -lc_nonshared"
      end
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
      case @libc_version
      when '2.23', '2.27'
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
      if @libc_version.to_f >= 2.32
        system "install -Dt #{CREW_DEST_PREFIX}/bin -m755 build-locale-archive"
        system "make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locales"
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
    # Tests on i686 fail.
    # /usr/local/bin/nm: /usr/local/tmp/crew/glibc.20211222010048.dir/glibc-2.23/glibc_build/elf/../string/rtld-memcpy-sse2-unaligned.os: no symbols
    # /usr/local/bin/nm: /usr/local/tmp/crew/glibc.20211222010048.dir/glibc-2.23/glibc_build/elf/../string/rtld-memmove-sse2-unaligned.os: no symbols
    # make[2]: Target 'tests' not remade because of errors.
    # rm /usr/local/tmp/crew/glibc.20211222010048.dir/glibc-2.23/glibc_build/libc.dynsym /usr/local/tmp/crew/glibc.20211222010048.dir/glibc-2.23/glibc_build/elf/ld.dynsym
    # make[2]: Leaving directory '/usr/local/tmp/crew/glibc.20211222010048.dir/glibc-2.23/elf'
    # make[1]: *** [Makefile:214: elf/tests] Error 2
    # make[1]: Target 'check' not remade because of errors.
    # make[1]: Leaving directory '/usr/local/tmp/crew/glibc.20211222010048.dir/glibc-2.23'
    # make: *** [Makefile:9: check] Error 2
    return if ARCH == 'i686'

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
    return unless @libc_version.to_f >= 2.32 && Gem::Version.new(CREW_KERNEL_VERSION.to_s) >= Gem::Version.new('5.10')

    puts 'Paring locales to a minimal set.'.lightblue
    system 'localedef --list-archive | grep -v -i -e ^en -e ^cs -e ^de -e ^es -e ^fa -e ^fe -e ^it -e ^ja -e ^ru -e ^tr -e ^zh -e ^C| xargs localedef --delete-from-archive',
           exception: false
    FileUtils.mv "#{CREW_LIB_PREFIX}/locale/locale-archive", "#{CREW_LIB_PREFIX}/locale/locale-archive.tmpl"
    unless File.file?('')
      downloader "https://raw.githubusercontent.com/bminor/glibc/release/#{@crew_libc_version}/master/intl/locale.alias",
                 'SKIP', "#{CREW_PREFIX}/share/locale/locale.alias"
    end
    if @opt_verbose
      system 'build-locale-archive'
    else
      system 'build-locale-archive', %i[out err] => File::NULL
    end
    FileUtils.rm "#{CREW_LIB_PREFIX}/locale/locale-archive.tmpl"
    # minimum set of locales -> #{CREW_LIB_PREFIX}/locale/locale-archive
    # We just whitelist certain locales and delete everything else like other distributions do, e.g.
    # for dir in locale i18n; do
    # find #{CREW_PREFIX}/usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rf {} +
    # done
    # This is the array of locales to save:
    @locales = %w[C cs_CZ de_DE en es_MX fa_IR fr_FR it_IT ja_JP ru_RU tr_TR zh]
    @localedirs = %W[#{CREW_PREFIX}/share/locale #{CREW_PREFIX}/share/i18n/locales]
    @filelist = File.readlines("#{CREW_META_PATH}/glibc.filelist")
    @localedirs.each do |localedir|
      Dir.chdir localedir do
        Dir['*'].each do |f|
          next if @locales.any? { |s| File.basename(f).include?(s) }

          FileUtils.rm_f f
          @fpath = "#{localedir}/#{f}"
          @filelist.reject! { |e| e.include?(@fpath) }
        end
      end
    end
    puts 'Updating glibc package filelist...'.lightblue
    File.open("#{CREW_META_PATH}/glibc.filelist", 'w+') do |f|
      f.puts(@filelist)
    end
  end
end
