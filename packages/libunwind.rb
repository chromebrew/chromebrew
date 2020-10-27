require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.5.0-rc2'
  compatibility 'all'
  source_url 'https://github.com/libunwind/libunwind/archive/v1.5-rc2.tar.gz'
  source_sha256 '94b8d0bb3057ef73c39bdd451590f6d20595cbba333654cc220c79db7a9e2dc9'

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
    system './autogen.sh'
    system "./configure #{CREW_OPTIONS} --enable-ptrace"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
