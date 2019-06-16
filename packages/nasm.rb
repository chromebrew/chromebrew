require 'package'

class Nasm < Package
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '2.14.02'
  source_url 'https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.xz'
  source_sha256 'e24ade3e928f7253aa8c14aa44726d1edf3f98643f87c9d72ec1df44b26be8f5'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
