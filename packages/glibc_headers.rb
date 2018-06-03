require 'package'

class Glibc_headers < Package
  description 'GNU C Library Headers'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.24'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.24.tar.xz'
  source_sha256 '99d4a3e8efd144d71488e478f62587578c0f4e1fa0b4eed47ee3d4975ebeb5d3'

  depends_on 'libc6'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/stdlib"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/libio"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/posix"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/wcsmbs"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/time"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/string"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/locale"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/intl"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/ctype"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/signal"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/misc"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/io"
    system "cp", "-r", "include", "#{CREW_DEST_PREFIX}"
    system "cp", "-r", "bits", "#{CREW_DEST_PREFIX}/include/"
    system "cp", "-r", "stdlib/errno.h", "#{CREW_DEST_PREFIX}/include/stdlib/"
    system "cp", "-r", "libio/stdio.h", "#{CREW_DEST_PREFIX}/include/libio/"
    system "cp", "-r", "posix/bits", "#{CREW_DEST_PREFIX}/include/posix/"
    system "cp", "-r", "libio/bits", "#{CREW_DEST_PREFIX}/include/libio/"
    system "cp", "-r", "wcsmbs/bits", "#{CREW_DEST_PREFIX}/include/wcsmbs/"
    system "cp", "-r", "posix/sys", "#{CREW_DEST_PREFIX}/include/posix/"
    system "cp", "-r", "posix/unistd.h", "#{CREW_DEST_PREFIX}/include/posix/"
    system "cp", "-r", "time/sys", "#{CREW_DEST_PREFIX}/include/time/"
    system "cp", "-r", "time/time.h", "#{CREW_DEST_PREFIX}/include/time/"
    system "cp", "-r", "string/endian.h", "#{CREW_DEST_PREFIX}/include/string/"
    system "cp", "-r", "string/bits", "#{CREW_DEST_PREFIX}/include/string/"
    system "cp", "-r", "locale/bits", "#{CREW_DEST_PREFIX}/include/locale/"
    system "cp", "-r", "locale/locale.h", "#{CREW_DEST_PREFIX}/include/locale/"
#    system "cp", "-r", "sysdeps/generic/string_private.h", "#{CREW_DEST_PREFIX}/include/"
    system "cp", "-r", "string/string.h", "#{CREW_DEST_PREFIX}/include/string/"
    system "cp", "-r", "string/strings.h", "#{CREW_DEST_PREFIX}/include/string/"
    system "cp", "-r", "intl/libintl.h", "#{CREW_DEST_PREFIX}/include/intl/"
    system "cp", "-r", "ctype/ctype.h", "#{CREW_DEST_PREFIX}/include/ctype/"
    system "cp", "-r", "signal/signal.h", "#{CREW_DEST_PREFIX}/include/signal/"
    system "cp", "-r", "signal/bits", "#{CREW_DEST_PREFIX}/include/signal/"
    system "cp", "-r", "misc/sys", "#{CREW_DEST_PREFIX}/include/misc/"
    system "cp", "-r", "io/fcntl.h", "#{CREW_DEST_PREFIX}/include/io/"
    system "cp", "-r", "io/sys", "#{CREW_DEST_PREFIX}/include/io/"
    system "cp", "-r", "stdlib/stdlib.h", "#{CREW_DEST_PREFIX}/include/stdlib/"
    system "cp", "-r", "stdlib/bits", "#{CREW_DEST_PREFIX}/include/stdlib/"
    system "cp", "-r", "stdlib/sys", "#{CREW_DEST_PREFIX}/include/stdlib/"
    system "cp", "-r", "stdlib/alloca.h", "#{CREW_DEST_PREFIX}/include/stdlib/"
#    system "cp", "-r", "sysdeps/generic/stackinfo.h", "#{CREW_DEST_PREFIX}/include/"
#    system "cp", "-r", "sysdeps/generic/allocalim.h", "#{CREW_DEST_PREFIX}/include/"
  end
end
