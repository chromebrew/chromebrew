require 'package'

class Glibc_build237 < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.37-1'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  # @libc_version = LIBC_VERSION
  @libc_version = '2.37'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc version.split('-').first
  max_glibc version.split('-').first
  source_url 'https://github.com/bminor/glibc.git'
  git_hashtag 'glibc-2.37'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fffbe32d69e3d972c9c845e8fa244159d7ac8b82ae9f07206c7189b20e3457c8',
     armv7l: 'fffbe32d69e3d972c9c845e8fa244159d7ac8b82ae9f07206c7189b20e3457c8',
     x86_64: '890a2ba75346498bb20165d55ee2d91bcb57d8c65df485029a5b8a20a5f73c19'
  })

  depends_on 'gawk' => :build
  depends_on 'filecmd' # L Fixes creating symlinks on a fresh install.
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build
  depends_on 'patchelf' # L

  conflicts_ok
  no_env_options
  no_upstream_update

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

    @googlesource_branch = 'release-R128-15964.B'
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
        when 'i686'
          FileUtils.ln_sf "/lib/ld-#{@libc_version}.so", 'ld-linux-i686.so.2'
          # newer x86_64 ChromeOS glibc lacks strtof128, strfromf128
          # and __strtof128_nan
          # when 'x86_64'
          #   FileUtils.ln_sf '/lib64/ld-linux-x86-64.so.2', 'ld-linux-x86-64.so.2.system'
        end
        if ARCH == 'x86_64'
          # Save our copy of libc.so.6
          FileUtils.mv File.join(CREW_DEST_LIB_PREFIX, 'libc.so.6'), File.join(CREW_DEST_LIB_PREFIX, 'libC.so.6')

          # Make a symlink to the system libc.so.6, which will require patchelf run on it in the postinstall.
          FileUtils.ln_sf "/#{ARCH_LIB}/libc.so.6", 'libc.so.6'

          ## Also save our copy of libm.so.6 since it has the float128 functions.
          ## Reject entries which aren't libraries ending in .so, and which aren't files.
          ## Reject text files such as libc.so because they points to files like
          ## libc_nonshared.a, which are not provided by ChromeOS
          # Dir["{,/usr}/#{ARCH_LIB}/#{lib}.so*"].compact.reject { |f| File.directory?(f) }.each do |f|
          # @filetype = `file #{f}`.chomp
          # puts "f: #{@filetype}" if @opt_verbose
          # if ['shared object', 'symbolic link'].any? { |type| @filetype.include?(type) }
          # g = File.basename(f)
          # FileUtils.ln_sf f.to_s, "#{CREW_DEST_LIB_PREFIX}/#{g}"
          # elsif @opt_verbose
          # puts "#{f} excluded because #{@filetype}"
          # end
          # end
          # Link our libm to also require our renamed libC.so.6
          # which provides the float128 functions strtof128, strfromf128,
          # and __strtof128_nan.
          libc_patch_libraries = %w[libm.so.6]
          libc_patch_libraries.each do |lib|
            system "patchelf --replace-needed libc.so.6 libC.so.6 #{lib}"
          end
        end
      end
    end
    # Only save libnsl.so.2, since libnsl.so.1 is provided by perl
    # For this to work, build on a M107 or newer container.
    FileUtils.ln_sf File.realpath("#{CREW_DEST_LIB_PREFIX}/libnsl.so.1"), "#{CREW_DEST_LIB_PREFIX}/libnsl.so.2" if LIBC_VERSION.to_f >= 2.35
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
    # Handle broken system glibc affecting system glibc and libm.so.6 on newer x86_64 ChromeOS milestones.
    if (ARCH == 'x86_64') && Gem::Version.new(LIBC_VERSION.to_s) >= Gem::Version.new('2.35')
      FileUtils.cp "/#{ARCH_LIB}/libc.so.6", File.join(CREW_LIB_PREFIX, 'libc.so.6.system') and FileUtils.mv File.join(CREW_LIB_PREFIX, 'libc.so.6.system'), File.join(CREW_LIB_PREFIX, 'libc.so.6')
      puts "patchelf is needed. Please run: 'crew install patchelf ; crew postinstall #{name}'".lightred unless File.file?(File.join(CREW_PREFIX, 'bin/patchelf'))
      # Link the system libc.so.6 to also require our renamed libC.so.6
      # which provides the float128 functions strtof128, strfromf128,
      # and __strtof128_nan.
      libc_patch_libraries = %w[libc.so.6 libm.so.6 libstdc++.so.6]
      libc_patch_libraries.keep_if { |lib| File.file?(File.join(CREW_LIB_PREFIX, lib)) }
      libc_patch_libraries.delete_if { |lib| Kernel.system "patchelf --print-needed #{File.join(CREW_LIB_PREFIX, lib)} | grep -q libC.so.6" }

      return if libc_patch_libraries.empty?

      if File.file?(File.join(CREW_LIB_PREFIX, 'libC.so.6'))
        Dir.chdir(CREW_LIB_PREFIX) do
          libc_patch_libraries.each do |lib|
            Kernel.system "patchelf --add-needed libC.so.6 #{lib}" and Kernel.system "patchelf --remove-needed libc.so.6 #{lib}"
            puts "#{lib} patched for use with Chromebrew's glibc.".lightgreen
          end
        end
      end
    end

    unless ARCH == 'x86_64'
      if File.exist?("#{CREW_LIB_PREFIX}/libc.so.6")
        FileUtils.chmod 'u=wrx', "#{CREW_LIB_PREFIX}/libc.so.6"
        @crew_libcvertokens = `#{CREW_LIB_PREFIX}/libc.so.6`.lines.first.chomp.split(/\s/)
        @libc_version = @crew_libcvertokens[@crew_libcvertokens.find_index('version') + 1].sub!(/[[:punct:]]?$/, '')
        puts "Package glibc version is #{@libc_version}.".lightblue
      else
        @libc_version = LIBC_VERSION
      end
      @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                      libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                      libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                      libthread_db libresolv librlv librt libthread_db-1.0 libutil]
      @libraries -= ['libpthread'] if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.35')
      @libraries -= ['libc'] if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.35') && Kernel.system("patchelf --print-needed #{File.join(CREW_LIB_PREFIX, 'libc.so.6')} | grep -q libC.so.6")
      @libraries -= ['libm'] if Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.35') && Kernel.system("patchelf --print-needed #{File.join(CREW_LIB_PREFIX, 'libm.so.6')} | grep -q libC.so.6")
      Dir.chdir CREW_LIB_PREFIX do
        puts "System glibc version is #{@libc_version}.".lightblue
        puts 'Creating symlinks to system glibc version to prevent breakage.'.lightblue
        case ARCH
        when 'aarch64', 'armv7l'
          FileUtils.ln_sf '/lib/ld-linux-armhf.so.3', 'ld-linux-armhf.so.3'
        end
        @libraries.each do |lib|
          # Reject entries which aren't libraries ending in .so, and which aren't files.
          # Reject text files such as libc.so because they points to files like
          # libc_nonshared.a, which are not provided by ChromeOS
          Dir["{,/usr}/#{ARCH_LIB}/#{lib}.so*"].compact.select { |i| ['shared object', 'symbolic link'].any? { |j| `file #{i}`.chomp.include? j } }.each do |k|
            FileUtils.ln_sf k, File.join(CREW_LIB_PREFIX, File.basename(k))
          end
        end
      end
    end
    return unless Gem::Version.new(@libc_version.to_s) > Gem::Version.new('2.32') && Gem::Version.new(CREW_KERNEL_VERSION.to_s) >= Gem::Version.new('5.10')

    puts 'Paring locales to a minimal set.'.lightblue
    system 'localedef --list-archive | grep -v -i -e ^en -e ^cs -e ^de -e ^es -e ^fa -e ^fe -e ^it -e ^ja -e ^ru -e ^tr -e ^zh -e ^C| xargs localedef --delete-from-archive',
           exception: false
    FileUtils.mv "#{CREW_LIB_PREFIX}/locale/locale-archive", "#{CREW_LIB_PREFIX}/locale/locale-archive.tmpl"
    unless File.file?('')
      downloader "https://raw.githubusercontent.com/bminor/glibc/release/#{@libc_version}/master/intl/locale.alias",
                 'SKIP', "#{CREW_PREFIX}/share/locale/locale.alias"
    end
    if CREW_VERBOSE
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
    @filelist = File.readlines("#{CREW_META_PATH}/glibc_build237.filelist")
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
    File.open("#{CREW_META_PATH}/glibc_build237.filelist", 'w+') do |f|
      f.puts(@filelist)
    end
  end
end
