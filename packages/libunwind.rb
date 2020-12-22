require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.5.0'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.5.0.tar.gz'
  source_sha256 '90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1efb1017'

  depends_on 'xzutils' => :build

  # Fixes GCC 10 compilation.
  # As per https://github.com/libunwind/libunwind/pull/166
  # Fixes llvm11 compilation as per
  # https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=230399#c9
  ENV['CFLAGS'] = '-fcommon -fexceptions -funwind-tables'
  def self.build
    system "./configure #{CREW_OPTIONS} --enable-ptrace"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
