require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'http://www.nongnu.org/libunwind/'
  version '1.2'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.2.tar.gz'
  source_sha256 '1de38ffbdc88bd694d10081865871cd2bfbb02ad8ef9e1606aee18d65532b992'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libunwind-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libunwind-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libunwind-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libunwind-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '30d9eb139a6ad3ecb805f03b9f9557b1ed8b5bb00afcacf72ce49d19b942c4f2',
     armv7l: '30d9eb139a6ad3ecb805f03b9f9557b1ed8b5bb00afcacf72ce49d19b942c4f2',
       i686: 'd4a2944a113114bb6be8496d985d4dd04ac6ec340fd592f6ef0a65761ac0f5b5',
     x86_64: '3df32f8d1e33e96ba5d0d3d821d85bb04d1bad436663f390815419ea9f024d46',
  })

  depends_on 'buildessential' => :build
  depends_on 'openssl' => :build
  depends_on 'xzutils' => :build

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
