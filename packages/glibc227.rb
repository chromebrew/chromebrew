require 'package'

class Glibc227 < Package
  description 'GNU C Library version 2.27'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.27'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
  source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

  depends_on 'glibc_headers' => :build
  depends_on 'python3' => :build
  depends_on 'libselinux' => :build
  depends_on 'libgd' => :build
  depends_on 'texinfo' => :build
  depends_on 'libcap' => :build
  

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
        puts "Had to patch, continuing...".lightgreen
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
               "--disable-sanity-checks",
               "--enable-shared",
               "--enable-kernel=3.18.0",
               "--enable-obsolete-rpc",
               "libc_cv_forced_unwind=yes"
      when 'x86_64'
        system "echo \"slibdir=#{CREW_LIB_PREFIX}\" > configparms"
        puts "echo \"slibdir=#{CREW_LIB_PREFIX}\" > configparms"
        system "../configure",
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-headers=#{CREW_PREFIX}/include",
               "--enable-shared",
               "--enable-kernel=3.18.0",
               "--disable-sanity-checks",
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
               "--enable-shared",
               "--enable-kernel=3.18.0",
               "--disable-multilib",
               "--disable-sanity-checks",
               "--enable-obsolete-rpc",
               "libc_cv_forced_unwind=yes",
               "libc_cv_ssp=no",
               "libc_cv_ssp_strong=no"
      end
      system "make"
    end
  end

  def self.check
    Dir.chdir "glibc_build" do
      system "make -k -j#{CREW_NPROC} check"
    end
  end

  def self.install
    Dir.chdir "glibc_build" do
      system "mkdir -pv #{CREW_DEST_PREFIX}/etc"
      system "touch","#{CREW_DEST_PREFIX}/etc/ld.so.conf"
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "localedata/install-locales"  # This installs full locales, but it has large disk size.
    end
  end
end
