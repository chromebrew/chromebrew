require 'package'

class Nasm < Package
  description 'The Netwide Assembler'
  homepage 'https://www.nasm.us/'
  version '2.14.02'
  compatibility 'all'
  source_url 'https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.xz'
  source_sha256 'e24ade3e928f7253aa8c14aa44726d1edf3f98643f87c9d72ec1df44b26be8f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14.02-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14.02-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14.02-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nasm-2.14.02-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f63ec3e4cbfa87aaccf94c33c608324bfca004f798502485c1b04994f73a47ae',
     armv7l: 'f63ec3e4cbfa87aaccf94c33c608324bfca004f798502485c1b04994f73a47ae',
       i686: '86bb6fa809e9b44a6677da1de4bc1efbcad9fd22450f092ef146f524c7c51eca',
     x86_64: 'd7ad212d782c300a90293b2cbd389c8b343e2f6c9a36422f2e1ce8fca75e3988',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
