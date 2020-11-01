require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.3.2.tar.gz'
  source_sha256 '0a4b5a78d8c0418dfa610245f75fa03ad45d8e5e4cc091915d2dbed34c01178e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5c5014f1e6e2a7e7de67ddaa672db78d29cc20177b7ac29d0c882c8976a71fe9',
     armv7l: '5c5014f1e6e2a7e7de67ddaa672db78d29cc20177b7ac29d0c882c8976a71fe9',
       i686: '96c33e31c23bbc6bf4a2d2fab4f5d2dbf7c6ef735ab9abbdb601832224543f33',
     x86_64: '92dd87431bfaa3f47dc527e8161e196cc0546b60b96a093a0dce265c8bd6c838',
  })

  depends_on 'xzutils' => :build

  # Fixes GCC 10 compilation.
  # As per https://github.com/libunwind/libunwind/pull/166
  ENV['CFLAGS'] = '-fcommon'
  def self.build
    system "./configure #{CREW_OPTIONS} --enable-ptrace"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
