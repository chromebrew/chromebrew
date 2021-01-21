require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.5.0'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.5.0.tar.gz'
  source_sha256 '90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1efb1017'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '96274d710810abd35f6a38f1c2d8c39f85959cc26de07f98a78dd27ff03dce9c',
     armv7l: '96274d710810abd35f6a38f1c2d8c39f85959cc26de07f98a78dd27ff03dce9c',
       i686: '508923a9dbdbacb0eeab2244db0c7caca2e8bcd3acd4d1c154c63eb600483937',
     x86_64: '3453e7f9438a665df84f39fcbd1c996009988480f05ec3489712efdf3c1499e0',
  })

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
