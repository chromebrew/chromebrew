require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.3.1'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.3.1.tar.gz'
  source_sha256 '43997a3939b6ccdf2f669b50fdb8a4d3205374728c2923ddc2354c65260214f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.3.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f156d2f13cd1cb5f62ab67e5f97f3866bfbb1ee5dd36830635ac89d1fea8b8d1',
     armv7l: 'f156d2f13cd1cb5f62ab67e5f97f3866bfbb1ee5dd36830635ac89d1fea8b8d1',
       i686: '0eeee073903fbe10cdc818e9da21caad07daff07b10ae9a1f7513277a42e5bc2',
     x86_64: '5b7de2da3534ee138cd258ed3202eca570cc77ef584353c011c6111fd6b0b024',
  })

  depends_on 'xzutils' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-ptrace'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
