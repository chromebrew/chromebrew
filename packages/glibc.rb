require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'

  depends_on 'gawk' => :build
  depends_on 'libgd' => :build
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build
  depends_on 'hashpipe' => :build

  # enable-obsolete-rpc should NOT be included as a build option as
  # this functionality is provided by libtirpc

  case LIBC_VERSION
  when '2.23'
    version LIBC_VERSION
    compatibility 'i686'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.23.tar.xz'
    source_sha256 '94efeb00e4603c8546209cefb3e1a50a5315c86fa9b078b6fad758e187ce13e9'

    binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.23_i686/glibc-2.23-chromeos-i686.tar.xz'
    })
    binary_sha256({
      i686: '52145b65cb49c2751f69d4c46636f0685f2abb6685d8a080b71b2f091595a950'
    })
  when '2.27'
    version LIBC_VERSION
    compatibility 'x86_64 aarch64 armv7l'
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
  when '2.32' # All architectures with updates past M92.
    version '2.32-1'
    compatibility 'x86_64 aarch64 armv7l'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.32.tar.xz'
    source_sha256 '1627ea54f5a1a8467032563393e0901077626dc66f37f10ee6363bb722222836'

    binary_url({
      aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32-1_armv7l/glibc-2.32-1-chromeos-armv7l.tpxz',
       armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32-1_armv7l/glibc-2.32-1-chromeos-armv7l.tpxz',
       x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32-1_x86_64/glibc-2.32-1-chromeos-x86_64.tpxz'
    })
    binary_sha256({
      aarch64: '9a75b9c77f8a131268f8df3db2066fe0e23513a40cdf45e6093d14e11ee2d394',
       armv7l: '9a75b9c77f8a131268f8df3db2066fe0e23513a40cdf45e6093d14e11ee2d394',
       x86_64: '6f27b75e77a2613fff24d36aa176f8a352a26adb8f58fbe7e75e400b84699719'
    })

  end

  depends_on 'gawk' => :build
  depends_on 'hashpipe' => :build
  depends_on 'libgd' => :build
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build

  def self.patch
    case LIBC_VERSION
    when '2.23', '2.27'
      # Apply patch due to new version of binutils which causes compilation failure
      # http://lists.busybox.net/pipermail/buildroot/2017-August/199812.html
      Dir.chdir 'misc' do
        unless File.readlines('regexp.c').grep(/monitor/).any?
          system "sed -i 's,char \\*loc1,char \\*loc1 __attribute__ ((nocommon)),g' regexp.c"
          system "sed -i 's,char \\*loc2,char \\*loc2 __attribute__ ((nocommon)),g' regexp.c"
          system "sed -i 's,char \\*locs,char \\*locs __attribute__ ((nocommon)),g' regexp.c"
          puts 'Patched!'.lightgreen
        end
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
        system "patch -Np1 -i #{patch}"
      end
      @googlesource_branch = 'release-R92-13982.B'
      system "git clone --depth=1 -b  #{@googlesource_branch} https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay googlesource"
      Dir.glob('googlesource/sys-libs/glibc/files/local/glibc-2.32/*.patch').each do |patch|
        puts patch
        system "patch -Np1 < #{patch}"
      end
    end
  end

  def self.build
    Dir.mkdir 'glibc_build'
    Dir.chdir 'glibc_build' do
      case LIBC_VERSION
      when '2.23' # This is only for glibc 2.23
        system '../configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-headers=#{CREW_PREFIX}/include",
               '--disable-werror',
               '--disable-sanity-checks',
               '--enable-shared',
               '--disable-multilib',
               'libc_cv_forced_unwind=yes',
               'libc_cv_ssp=no',
               'libc_cv_ssp_strong=no'
      when '2.27'
        case ARCH
        when 'armv7l', 'aarch64'
          system '../configure',
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--with-headers=#{CREW_PREFIX}/include",
                 '--disable-werror',
                 '--disable-sanity-checks',
                 '--enable-shared',
                 'libc_cv_forced_unwind=yes',
                 '--without-selinux'
        when 'x86_64'
          IO.write('configparms', "slibdir=#{CREW_LIB_PREFIX}")
          system '../configure',
                 "--prefix=#{CREW_PREFIX}",
                 "--libdir=#{CREW_LIB_PREFIX}",
                 "--with-headers=#{CREW_PREFIX}/include",
                 '--disable-werror',
                 '--disable-sanity-checks',
                 '--enable-shared',
                 '--disable-multilib',
                 'libc_cv_forced_unwind=yes',
                 'libc_cv_ssp=no',
                 'libc_cv_ssp_strong=no'
        end
      when '2.32'
        # Optimization flags from https://github.com/InBetweenNames/gentooLTO
        case ARCH
        when 'armv7l', 'aarch64'
          system "env CFLAGS='-pipe -O2 -fipa-pta -fno-semantic-interposition -fdevirtualize-at-ltrans' \
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
            --enable-hacker-mode \
            --enable-kernel=3.18 \
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
            --without-cvs \
            --without-selinux \
            --with-bugurl=https://github.com/skycocker/chromebrew/issues/new \
            "
          # install-symbolic-link segfaults on armv7l, but we're deleting
          # the libraries anyways, so it doesn't matter.
          system "sed -i 's,install-symbolic-link,/bin/true,g' ../Makefile"
          system "sed -i 's,symbolic-link-prog := \$(elf-objpfx)sln,symbolic-link-prog := /bin/true,g' ../Makerules"
        when 'x86_64'
          IO.write('configparms', "slibdir=#{CREW_LIB_PREFIX}")
          system "env \
          CFLAGS='-pipe -O2 -fipa-pta -fno-semantic-interposition -falign-functions=32 -fdevirtualize-at-ltrans' \
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
            --enable-kernel=3.10 \
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
            --without-cvs \
            --without-selinux \
            --with-bugurl=https://github.com/skycocker/chromebrew/issues/new \
            "
        end
      end
      system 'make'
      case @LIBC_VERSION
      when '2.32'
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
      system "install -Dt #{CREW_DEST_PREFIX}/bin -m755 build-locale-archive"
      system 'touch', "#{CREW_DEST_PREFIX}/etc/ld.so.conf"
      system "make DESTDIR=#{CREW_DEST_DIR} install" # "sln elf/symlink.list" fails on armv7l
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'localedata/install-locales'
    end
    # Remove libmount.so since it conflicts with the one from util_linux.
    FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/libmount.so.*")
  end

  # def self.check
  # Dir.chdir 'glibc_build' do
  # system "make -k -j#{CREW_NPROC} check"
  # end
  # end

  def self.postinstall
    @crew_libcvertokens = `#{CREW_LIB_PREFIX}/libc.so.6`.lines.first.chomp.split(/\s/)
    @crew_libc_version = @crew_libcvertokens[@crew_libcvertokens.find_index('version') + 1].sub!(/[[:punct:]]?$/, '')
    @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                    libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                    libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                    libresolv librlv librt libthread_db-1.0 libutil]
    Dir.chdir CREW_LIB_PREFIX do
      if @crew_libc_version != LIBC_VERSION
        puts "Package glibc version is #{@crew_libc_version}.".lightblue
        puts "System glibc version is #{LIBC_VERSION}.".lightblue
        puts 'Creating symlinks to system glibc version to prevent breakage.'.lightblue
        @libraries.each do |lib|
          Dir.glob("/#{ARCH_LIB}/#{lib}*").each do |f|
            if `file #{f} | grep "shared object"`
              g = File.basename(f)
              FileUtils.ln_sf f.to_s, g.to_s
            end
          end
        end
      end
    end
    case LIBC_VERSION
    when '2.32'
      puts 'Paring locales to a minimal set.'.lightblue
      system 'localedef --list-archive | grep -v -i -e ^en -e ^cs -e ^de -e ^es -e ^fa -e ^fe -e ^it -e ^ja -e ^ru -e ^tr -e ^zh -e ^C| xargs localedef --delete-from-archive'
      FileUtils.mv "#{CREW_LIB_PREFIX}/locale/locale-archive", "#{CREW_LIB_PREFIX}/locale/locale-archive.tmpl"
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
      @filelist = IO.readlines("#{CREW_META_PATH}#{to_s.downcase}.filelist")
      @localedirs.each do |localedir|
        Dir.chdir localedir do
          Dir.glob('*').each do |f|
            next if @locales.any? { |s| File.basename(f).include?(s) }

            FileUtils.rm_f f
            @fpath = "#{localedir}/#{f}"
            #puts "Removed #{@fpath}.".orange
            @filelist.reject! { |e| e =~ /#{@fpath}/ }
          end
        end
      end
      puts "Updating #{to_s.downcase} package filelist...".lightblue
      File.open("#{CREW_META_PATH}#{to_s.downcase}.filelist", 'w+') do |f|
        f.puts(@filelist)
      end
    end
  end
end
