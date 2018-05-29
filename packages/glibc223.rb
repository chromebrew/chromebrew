require 'package'

class Glibc223 < Package
  description 'GNU C Library version 2.23'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.23-3'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.23.tar.xz'
  source_sha256 '94efeb00e4603c8546209cefb3e1a50a5315c86fa9b078b6fad758e187ce13e9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibc223-2.23-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibc223-2.23-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibc223-2.23-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibc223-2.23-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de8de509b8296b73539a6ee06aefed5df9f3fa56e2d086addecc817f2eaeb1f2',
     armv7l: 'de8de509b8296b73539a6ee06aefed5df9f3fa56e2d086addecc817f2eaeb1f2',
       i686: 'f76de42054c1413d88618a218b9933056a0b31aaf6818043bee82a2ead245522',
     x86_64: '9989a2208ede7055127780de0990d8bc6dd60379535c7d18a52da0742117bca9',
  })

  depends_on 'libgd' => :build
  depends_on 'texinfo' => :build

  def self.patch
    # Apply patch due to new version of binutils  which causes compilation failure
    # http://lists.busybox.net/pipermail/buildroot/2017-August/199812.html
    Dir.chdir "misc" do
      if File.readlines("regexp.c").grep(/monitor/).any?
        puts "Patched!".lightgreen
      else
        system "sed -i 's,char \\*loc1,char \\*loc1 __attribute__ ((nocommon)),g' regexp.c"
        system "sed -i 's,char \\*loc2,char \\*loc2 __attribute__ ((nocommon)),g' regexp.c"
        system "sed -i 's,char \\*locs,char \\*locs __attribute__ ((nocommon)),g' regexp.c"
      end
    end
  end

  def self.build
    system "mkdir -pv glibc_build"
    Dir.chdir "glibc_build" do
      case ARCH
      when 'armv7l' || 'aarch64'
        system "../configure",
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-headers=#{CREW_PREFIX}/include",
               "--disable-werror",
               "--disable-sanity-checks",
               "--enable-shared",
               "--enable-obsolete-rpc",
               "libc_cv_forced_unwind=yes"
      when 'x86_64'
        system "echo \"slibdir=#{CREW_LIB_PREFIX}\" > configparms"
        puts "echo \"slibdir=#{CREW_LIB_PREFIX}\" > configparms"
        system "../configure",
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-headers=#{CREW_PREFIX}/include",
               "--disable-werror",
               "--disable-sanity-checks",
               "--enable-shared",
               "--disable-multilib",
               "--enable-obsolete-rpc",
               "libc_cv_forced_unwind=yes",
               "libc_cv_ssp=no",
               "libc_cv_ssp_strong=no"
      when 'i686'
        system "../configure",
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-headers=#{CREW_PREFIX}/include",
               "--disable-werror",
               "--disable-sanity-checks",
               "--enable-shared",
               "--disable-multilib",
               "--enable-obsolete-rpc",
               "libc_cv_forced_unwind=yes",
               "libc_cv_ssp=no",
               "libc_cv_ssp_strong=no"
      end
      system "make"
    end
  end

  def self.install
    Dir.chdir "glibc_build" do
      system "mkdir -pv #{CREW_DEST_PREFIX}/etc"
      system "touch","#{CREW_DEST_PREFIX}/etc/ld.so.conf"
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      #system "make", "DESTDIR=#{CREW_DEST_DIR}", "localedata/install-locales"  # This installs full locales, but it has large disk size.
    end
      
    # minimum set of locales -> /usr/local/lib(64)/locale/locale-archive
    Dir.chdir "glibc_build/localedata" do
      system "mkdir -pv #{CREW_DEST_LIB_PREFIX}/locale"
      puts "Install minimum set of locales".lightblue
      
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
  
  #def self.check
  #  Dir.chdir "glibc_build" do
  #    system "make -k -j#{CREW_NPROC} check"
  #  end
  #end
  
end
