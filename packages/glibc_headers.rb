require 'package'

class Glibc_headers < Package
  description 'GNU C Library Headers'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.27'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
  source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

  depends_on 'libc6'

  def self.install
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/stdlib"
    system "mkdir", "-p", "#{CREW_DEST_PREFIX}/include/libio"
    system "cp", "-r", "include", "#{CREW_DEST_PREFIX}"
    system "cp", "-r", "bits", "#{CREW_DEST_PREFIX}/include"
    system "cp", "-r", "stdlib/errno.h", "#{CREW_DEST_PREFIX}/include/stdlib"
    system "cp", "-r", "libio/stdio.h", "#{CREW_DEST_PREFIX}/include/libio"
  end
end
