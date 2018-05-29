require 'package'

class Glibc_headers < Package
  description 'GNU C Library Headers'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.27'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
  source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

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
    end
  end

  def self.install
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "headers_install", "INSTALL_HDR_PATH=#{CREW_PREFIX}"
  end
end
