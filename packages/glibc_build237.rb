require 'package'

class Glibc_build237 < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.37-2'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  # @libc_version = LIBC_VERSION
  @libc_version = '2.37'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc version.split('-').first
  max_glibc version.split('-').first
  source_url 'https://github.com/bminor/glibc.git'
  # git_hashtag 'glibc-2.37'
  # From the release/2.37/master/ branch...
  git_hashtag 'f82e0922de82ccee60c15d5ffd9e7165ced00a83'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41389ad4ecc6183fca15e2335e20b1617585ea068eed0e280d05dec5aebd9e10',
     armv7l: '41389ad4ecc6183fca15e2335e20b1617585ea068eed0e280d05dec5aebd9e10',
     x86_64: '476d322fca4f023479303c2a39e638d1bfaf12b78693e3b3a96dbece93a76df2'
  })

  depends_on 'gawk' => :build
  depends_on 'filecmd' # L Fixes creating symlinks on a fresh install.
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build
  depends_on 'patchelf' # L

  conflicts_ok
  no_env_options
  # strip breaks libc.so.6
  no_strip
  no_upstream_update

  # These are the only locales we want.
  @locales = %w[C cs_CZ de_DE en es_MX fa_IR fr_FR it_IT ja_JP ru_RU tr_TR zh].to_set

  def self.patch
    FileUtils.mkdir 'fedora'
    # Patch to enable build-local-archive
    downloader 'https://src.fedoraproject.org/rpms/glibc/raw/f30/f/glibc-fedora-locarchive.patch', '0acccf57d8c6e7de82871c61ccb845f7a1ae13ae1fbc65995d347de8367c7bb1'
    system 'patch -Np1 -i glibc-fedora-locarchive.patch'
    downloader 'https://src.fedoraproject.org/rpms/glibc/raw/f30/f/build-locale-archive.c', '6834e8b8f2a987bf8adfd265c0e01665f102c7115db94b99ec36376b68e9d3fa', 'fedora/build-locale-archive.c'
    system "sed -i 's,/lib/locale,/lib#{CREW_LIB_SUFFIX}/locale,g' fedora/build-locale-archive.c"
    system "sed -i 's,/usr/sbin/tzdata-update,/bin/true,g' fedora/build-locale-archive.c"
    system "sed -i 's,verbose,locale_verbose,g' fedora/build-locale-archive.c"
    system "sed -i 's,be_quiet,locale_be_quiet,g' fedora/build-locale-archive.c"

    # Reverse Fix name space violation in fortify wrappers (bug 32052)
    # https://github.com/bminor/glibc/commit/6e642a47fa483f1f571a7ca68d8f6517b259cd21
    # It causes this error:
    # ../wcsmbs/bits/wchar2.h:248:10: error: implicit declaration of function ‘__vswprintf_alias’; did you mean ‘__swprintf_alias’? [-Wimplicit-function-declaration]
    downloader 'https://github.com/bminor/glibc/commit/6e642a47fa483f1f571a7ca68d8f6517b259cd21.diff', '6e9fd773c1ad1be331ea2a6d81452bc2e97f6e70942a670c98fd07d356f76dc9'
    puts 'Reversing patch: Fix name space violation in fortify wrappers (bug 32052)'
    system 'patch -Np1 -R -i 6e642a47fa483f1f571a7ca68d8f6517b259cd21.diff'

    @googlesource_branch = 'release-R129-16002.B'
    system "git clone --depth=1 -b  #{@googlesource_branch} https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay googlesource"
    # We need to avoid this patch to preserve float128. Otherwise strtof128,
    # strfromf128, and __strtof128_nan, are not available in our glibc.
    # This still requires hackery to avoid issues, as handled below by
    # renaming our libc.so.6 to libC.so.6 and using patchelf to add
    # needs for our libm.so.6 as well as the system provided libc.so.6.
    # gcc_lib's stdc++.so.6 also needs to be told to need our glibc's
    # renamed libC.so.6. Additionally, packages on these systems need to
    # be built with CREW_LINKER_FLAGS=' /usr/local/lib64/libC.so.6 ' set.
    #
    FileUtils.rm 'googlesource/sys-libs/glibc/files/local/glibc-2.37/0003-Disable-float128-support-for-x86_64-x86.patch'
    # Please submit suggestions for less hacky workarounds.
    #

    Dir.glob('googlesource/sys-libs/glibc/files/local/glibc-2.37/*.patch').each do |patch|
      puts "patch -Np1 < #{patch} || true" if @opt_verbose
      system "patch -Np1 -F 10 -i #{patch} || true"
    end
    return unless Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.32')

    # These are the only locales we want.
    @locales = %w[C cs_CZ de_DE en es_MX fa_IR fr_FR it_IT ja_JP ru_RU tr_TR zh].to_set
    puts 'Paring locales to a minimal set before build.'.lightblue

    localetypes = `awk -F '/' '{print $2}' localedata/SUPPORTED | sort -u | awk '{print $1}'`.split.flat_map(&:split)
    localetypes_sed = localetypes.join('|')
    Dir['localedata/{*.in,locales/*}'].compact.each do |f|
      g = File.basename(f).gsub(/.UTF-8.*.in/, '').gsub(/.ISO-8859-.*.in/, '')
      h = g.gsub(/_.*/, '')
      locale_test = [g, h].uniq
      # Just check to see if the set difference is smaller than the
      # original set of locales.
      if (@locales - locale_test).length < @locales.length
        puts "Saving locale: #{f}"
      else
        # FileUtils.rm(f)
        system "sed -i -r '/^[[:space:]]#{g}.*(#{localetypes_sed}).*\\\\/d' localedata/Makefile", exception: false
        system "sed -i -r '/^#{g}.*(#{localetypes_sed}).*\\\\/d' localedata/SUPPORTED", exception: false
      end
    end
  end

  def self.build
    FileUtils.mkdir_p 'glibc_build'
    Dir.chdir 'glibc_build' do
      if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.32')
        # Optimization flags from https://github.com/InBetweenNames/gentooLTO
        case ARCH
        when 'armv7l', 'aarch64'
          system "CFLAGS='-fuse-ld=mold -pipe -O2 -fipa-pta \
          -fno-semantic-interposition -fdevirtualize-at-ltrans' \
             ../configure \
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
            --enable-kernel=5.10 \
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
          # https://source.chromium.org/chromiumos/_/chromium/chromiumos/overlays/chromiumos-overlay/+/a73162d56fd689b26812282c3f9bc4f2b5a67530:sys-libs/glibc/glibc-2.37.ebuild
          File.write('configparms', "slibdir=#{CREW_LIB_PREFIX}", mode: 'a+')
          system "CFLAGS='-fuse-ld=mold -pipe -O2 -fipa-pta \
          -fno-semantic-interposition -falign-functions=32 \
          -fdevirtualize-at-ltrans -mstackrealign' \
            ../configure \
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
            --enable-kernel=5.10 \
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
      if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.32')
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
        system "make -j1 DESTDIR=#{CREW_DEST_DIR} install || make -j1 DESTDIR=#{CREW_DEST_DIR} install || true"
      end
      if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.32')
        system "install -Dt #{CREW_DEST_PREFIX}/bin -m755 build-locale-archive"
        system "make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locales || make -j1 DESTDIR=#{CREW_DEST_DIR} localedata/install-locales"
      end

      Dir.chdir CREW_DEST_LIB_PREFIX do
        puts "System glibc version is #{LIBC_VERSION}.".lightblue
        puts 'Creating symlinks to system glibc version to prevent breakage.'.lightblue
        case ARCH
        when 'aarch64', 'armv7l'
          FileUtils.ln_sf '/lib/ld-linux-armhf.so.3', 'ld-linux-armhf.so.3'
        when 'x86_64'
          FileUtils.ln_sf '/lib64/ld-linux-x86-64.so.2', 'ld-linux-x86-64.so.2'
          FileUtils.ln_sf '/lib64/ld-linux-x86-64.so.2', 'ld-lsb-x86-64.so.3'
        end
        # newer x86_64 ChromeOS glibc lacks strtof128, strfromf128
        # and __strtof128_nan
        if ARCH == 'x86_64' && Gem::Version.new(@libc_version.to_s) >= Gem::Version.new('2.37')
          # Save our copy of libc.so.6
          FileUtils.cp File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6'), File.join(CREW_DEST_LIB_PREFIX, 'libC.so.6')
          FileUtils.cp "/#{ARCH_LIB}/libc.so.6", File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6.tmp')
          # Patching the running libc.so.6 breaks.
          Kernel.system 'patchelf --add-needed libC.so.6 libc.so.6.tmp'
          FileUtils.cp File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6.tmp'), File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6')
          FileUtils.rm File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6.tmp')

          # Copy over the system lib[c,m].so.6
          # FileUtils.cp "/#{ARCH_LIB}/libc.so.6", File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6')
          # FileUtils.cp "/#{ARCH_LIB}/libm.so.6", File.join(CREW_DEST_LIB_PREFIX, 'libm.so.6')

          # Link our libm to also require our renamed libC.so.6
          # which provides the float128 functions strtof128, strfromf128,
          # and __strtof128_nan.
          # For some reason handling libc.so.6 here isn't working.
          libc_patch_libraries = %w[libm.so.6]
          libc_patch_libraries.each do |lib|
            FileUtils.cp lib, "#{lib}.tmp"
            Kernel.system "patchelf --add-needed libC.so.6 #{lib}.tmp"
            Kernel.system "patchelf --remove-needed libc.so.6 #{lib}.tmp", exception: false
            FileUtils.mv lib, "#{lib}.old"
            FileUtils.cp "#{lib}.tmp", lib
            FileUtils.rm "#{lib}.tmp"
            FileUtils.rm "#{lib}.old"
            puts "#{lib} patched for use with Chromebrew's glibc.".lightgreen
          end
        end
        @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                        libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                        libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                        libthread_db libresolv librlv librt libthread_db-1.0 libutil]
        @libraries -= ['libpthread'] if Gem::Version.new(@libc_version.to_s) >= Gem::Version.new('2.37')
        @libraries -= ['libc'] if Gem::Version.new(@libc_version.to_s) >= Gem::Version.new('2.37') && ARCH == 'x86_64'
        # Also save our copy of libm.so.6 since it has the float128 functions
        @libraries -= ['libm'] if Gem::Version.new(@libc_version.to_s) >= Gem::Version.new('2.37') && ARCH == 'x86_64'

        @libraries.each do |lib|
          # Reject entries which aren't libraries ending in .so, and which aren't files.
          # Reject text files such as libc.so because they points to files like
          # libc_nonshared.a, which are not provided by ChromeOS
          Dir["{,/usr}/#{ARCH_LIB}/#{lib}.so*"].compact.reject { |f| File.directory?(f) }.each do |f|
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
    FileUtils.ln_sf File.realpath("/#{ARCH_LIB}/libnsl.so.1"), "#{CREW_DEST_LIB_PREFIX}/libnsl.so.2" if LIBC_VERSION.to_f >= 2.35
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libnsl.so"
    FileUtils.rm_f "#{CREW_DEST_LIB_PREFIX}/libnsl.so.1"

    # Remove libmount.so since it conflicts with the one from util_linux.
    FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/libmount.so*")

    locale_keeps = @locales.map { |i| "-e ^#{i}" }.join(' ')

    system "localedef --list-archive --prefix=#{CREW_DEST_PREFIX}| grep -v -i #{locale_keeps}| xargs localedef --delete-from-archive --prefix=#{CREW_DEST_PREFIX}",
           exception: false
  end

  def self.postinstall
    return unless Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.32') && Gem::Version.new(CREW_KERNEL_VERSION.to_s) >= Gem::Version.new('5.10')

    FileUtils.mv "#{CREW_LIB_PREFIX}/locale/locale-archive", "#{CREW_LIB_PREFIX}/locale/locale-archive.tmpl"
    downloader "https://raw.githubusercontent.com/bminor/glibc/release/#{@libc_version}/master/intl/locale.alias",
               'SKIP', "#{CREW_PREFIX}/share/locale/locale.alias"
    # minimum set of locales -> #{CREW_LIB_PREFIX}/locale/locale-archive
    # We just whitelist certain locales and delete everything else like other distributions do, e.g.
    # for dir in locale i18n; do
    # find #{CREW_PREFIX}/usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rf {} +
    # done
    if CREW_VERBOSE
      system "build-locale-archive --install-langs=#{@locales.join(':')}", exception: false
    else
      system "build-locale-archive --install-langs=#{@locales.join(':')}", %i[out err] => File::NULL, exception: false
    end
    FileUtils.rm "#{CREW_LIB_PREFIX}/locale/locale-archive.tmpl"
  end
end
