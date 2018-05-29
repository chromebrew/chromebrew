require 'package'

class Glibc_headers < Package
  description 'GNU C Library Headers'
  homepage 'https://www.gnu.org/software/libc/'
  version '2.27'
  source_url 'https://ftpmirror.gnu.org/glibc/glibc-2.27.tar.xz'
  source_sha256 '5172de54318ec0b7f2735e5a91d908afe1c9ca291fec16b5374d9faadfc1fc72'

  def self.install
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "headers_install", "INSTALL_HDR_PATH=#{CREW_PREFIX}"
  end
end
