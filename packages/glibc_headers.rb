require 'package'

class Glibc_headers < Package
  description 'GNU C Library Headers'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.27'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
  source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

  depends_on 'libc6'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/stdlib"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/libio"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/posix"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/wcsmbs"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/time"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/string"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/locale"
    system "cp", "-r", "include", "#{CREW_DEST_PREFIX}"
    system "cp", "-r", "bits", "#{CREW_DEST_PREFIX}/include/"
    system "cp", "-r", "stdlib/errno.h", "#{CREW_DEST_PREFIX}/include/stdlib/"
    system "cp", "-r", "libio/stdio.h", "#{CREW_DEST_PREFIX}/include/libio/"
    system "cp", "-r", "posix/bits", "#{CREW_DEST_PREFIX}/include/posix/"
    system "cp", "-r", "libio/bits", "#{CREW_DEST_PREFIX}/include/libio/"
    system "cp", "-r", "wcsmbs/bits", "#{CREW_DEST_PREFIX}/include/wcsmbs/"
    system "cp", "-r", "posix/sys", "#{CREW_DEST_PREFIX}/include/posix/"
    system "cp", "-r", "time/bits", "#{CREW_DEST_PREFIX}/include/time/"
    system "cp", "-r", "time/sys", "#{CREW_DEST_PREFIX}/include/time/"
    system "cp", "-r", "time/time.h", "#{CREW_DEST_PREFIX}/include/time/"
    system "cp", "-r", "string/endian.h", "#{CREW_DEST_PREFIX}/include/string/"
    system "cp", "-r", "string/bits", "#{CREW_DEST_PREFIX}/include/string/"
    system "cp", "-r", "locale/bits", "#{CREW_DEST_PREFIX}/include/locale/"
  end
end
