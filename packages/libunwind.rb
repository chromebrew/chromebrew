require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.3.2'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.3.2.tar.gz'
  source_sha256 '0a4b5a78d8c0418dfa610245f75fa03ad45d8e5e4cc091915d2dbed34c01178e'

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
