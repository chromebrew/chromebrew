require 'package'

class Nasm < Package
  version '2.14rc16'
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  source_url 'https://www.nasm.us/pub/nasm/releasebuilds/2.14rc16/nasm-2.14rc16.tar.xz'
  source_sha256 '084482a7708c46ef6ab480488d29092cf9d4d5b9e8a5d0ba58d69eee1758f358'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
