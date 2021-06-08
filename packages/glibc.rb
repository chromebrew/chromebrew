require 'package'

class Glibc < Package
  description 'The GNU C Library project provides the core libraries for GNU/Linux systems.'
  homepage 'https://www.gnu.org/software/libc/'
  version LIBC_VERSION
  license 'LGPL-2.1+, BSD, HPND, ISC, inner-net, rc, and PCRE'
  compatibility 'all'
  
  depends_on 'gawk' => :build
  depends_on 'libgd' => :build
  depends_on 'libidn2' => :build
  depends_on 'texinfo' => :build

  # enable-obsolete-rpc should NOT be included as a build option as
  # this functionality is provided by libtirpc

  case LIBC_VERSION
  when '2.23'
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.23.tar.xz'
    source_sha256 '94efeb00e4603c8546209cefb3e1a50a5315c86fa9b078b6fad758e187ce13e9'

    binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.23_i686/glibc-2.23-chromeos-i686.tar.xz'
    })
    binary_sha256({
      i686: '52145b65cb49c2751f69d4c46636f0685f2abb6685d8a080b71b2f091595a950'
    })
  when '2.27'
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
    source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.32.tar.xz'
    source_sha256 '1627ea54f5a1a8467032563393e0901077626dc66f37f10ee6363bb722222836'

    binary_url({
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/glibc/2.32_x86_64/glibc-2.32-chromeos-x86_64.tpxz'
    })
    binary_sha256({
      x86_64: '0e6749f4d4c445e27bcd8669865fa060193552ecda2233f7f0d5e91c90b91a0b'
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
      FileUtils.mkdir_p 'gentoopatches'
      system 'curl -Ls https://dev.gentoo.org/~dilfridge/distfiles/glibc-2.32-patches-8.tar.xz \
        hashpipe 6653f1d0aadad10bd288f3bae274bd4e0a013d47f09ce78199fb5989b2d8fd9b | tar -xJf - -C gentoopatches'
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
            --disable-profile \
            --disable-sanity-checks \
            --disable-werror \
            --enable-bind-now \
            --enable-kernel=3.18 \
            --enable-shared \
            --enable-static-pie \
            libc_cv_c_cleanup=yes \
            libc_cv_forced_unwind=yes \
            "
        when 'x86_64'
          IO.write('configparms', "slibdir=#{CREW_LIB_PREFIX}")
          system "env \
          CFLAGS='-pipe -O2 -fipa-pta -fno-semantic-interposition -falign-functions=32 -fdevirtualize-at-ltrans' \
          LD=ld ../configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --with-headers=#{CREW_PREFIX}/include \
            --disable-profile \
            --disable-sanity-checks \
            --disable-werror \
            --enable-bind-now \
            --enable-cet \
            --enable-kernel=3.10 \
            --enable-shared \
            --enable-static-pie \
            libc_cv_c_cleanup=yes \
            libc_cv_forced_unwind=yes \
            "
        end
      end
      system 'make'
    end
  end

  def self.install
    @libraries = %w[ld libBrokenLocale libSegFault libanl libc libcrypt
                    libdl libm libmemusage libmvec libnsl libnss_compat libnss_db
                    libnss_dns libnss_files libnss_hesiod libpcprofile libpthread
                    librlv librt libthread_db-1.0 libutil]
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    Dir.chdir 'glibc_build' do
      system 'touch', "#{CREW_DEST_PREFIX}/etc/ld.so.conf"
      system "make DESTDIR=#{CREW_DEST_DIR} install" # "sln elf/symlink.list" fails on armv7l
      # This installs full locales, but requires a lot of disk space.
      # for 2.32, let's not bother with this, and just use the default install?
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'localedata/install-locales'
    end
    # Just let the system use all provided glibc libraries
    Dir.chdir CREW_DEST_LIB_PREFIX do
      @libraries.each do |lib|
      # Dir.glob("/#{ARCH_LIB}/#{lib}*").each do |f|
      #   if `file #{f} | grep "shared object"`
      #     g = File.basename(f)
      #     FileUtils.ln_sf f.to_s, g.to_s
      #   end
      # end
      
      FileUtils.rm Dir.glob("*")
      case ARCH
      when 'armv7l', 'aarch64'
        FileUtils.ln_sf "/#{ARCH_LIB}/ld-linux-armhf.so.3", 'ld-linux-armhf.so.3'
      when 'i686'
        FileUtils.ln_sf "/#{ARCH_LIB}/ld-linux.so.2", 'ld-linux.so.2'
      when 'x86_64'
        FileUtils.ln_sf "/#{ARCH_LIB}/ld-linux-x86-64.so.2", 'ld-linux-x86-64.so.2'
      end
    end
 
    # minimum set of locales -> #{CREW_LIB_PREFIX}/locale/locale-archive
    # May be better to just whitelist certain locales and delete everything else like other distributions do, e.g.
    # for dir in locale i18n; do
    # find /usr/share/${dir} -mindepth  1 -maxdepth 1 -type d -not \( -name "${KEEPLANG}" -o -name POSIX \) -exec rm -rf {} +
    # done
    # This would be a suggested array of locales to save:
    # @locales = %w[cs_CZ de_DE en_GB en_HK en_PH en_US es_MX fa_IR fr_FR it_IT ja_JP ru_RU tr_TR zh_CN]
    # Dir.chdir 'glibc_build' do
    # FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/locale"
    # puts 'Install minimum set of locales'.lightblue

    ## Could assume old version of glibc is installed & use localedef...
    ## But use the just-built localedef from the locale folder.
    ## If not installed, we can move following instruction to postinstall
    ## Since glibc is a basic package, we prefer to provide pre-compiled package.
    ## No complicated detect logics required -> make it as simple as possible

    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i cs_CZ -f UTF-8 cs_CZ.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i de_DE -f ISO-8859-1 de_DE"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i de_DE@euro -f ISO-8859-15 de_DE@euro"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i de_DE -f UTF-8 de_DE.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i en_GB -f UTF-8 en_GB.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i en_HK -f ISO-8859-1 en_HK"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i en_PH -f ISO-8859-1 en_PH"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i POSIX -f UTF-8 C.UTF-8 2> /dev/null || true"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i en_US -f ISO-8859-1 en_US"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i en_US -f UTF-8 en_US.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i es_MX -f ISO-8859-1 es_MX"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i fa_IR -f UTF-8 fa_IR"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i fr_FR -f ISO-8859-1 fr_FR"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i fr_FR@euro -f ISO-8859-15 fr_FR@euro"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i fr_FR -f UTF-8 fr_FR.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i it_IT -f ISO-8859-1 it_IT"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i it_IT -f UTF-8 it_IT.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i ja_JP -f EUC-JP ja_JP"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i ru_RU -f KOI8-R ru_RU.KOI8-R"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i ru_RU -f UTF-8 ru_RU.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i tr_TR -f UTF-8 tr_TR.UTF-8"
    # system "elf/ld.so --library-path . locale/localedef --prefix=#{CREW_DEST_DIR} -i zh_CN -f GB18030 zh_CN.GB18030"
    # end
    # Remove libmount.so since it conflicts with the one from util_linux.
    FileUtils.rm Dir.glob("#{CREW_DEST_LIB_PREFIX}/libmount.so.*")
  end

  def self.check
    Dir.chdir "glibc_build" do
      system "make -k -j#{CREW_NPROC} check"
    end
  end
end
