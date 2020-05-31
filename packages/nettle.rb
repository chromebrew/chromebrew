require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.5.1'
  source_url 'https://ftpmirror.gnu.org/nettle/nettle-3.5.1.tar.gz'
  source_sha256 '75cca1998761b02e16f2db56da52992aef622bf55a3b45ec538bc2eedadc9419'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nettle-3.5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a9605d17f44b2ca3f0aaad799a8f3100a803bc45bda5048a36012f9e0b7595dd',
     armv7l: 'a9605d17f44b2ca3f0aaad799a8f3100a803bc45bda5048a36012f9e0b7595dd',
       i686: '499d5354c73f68eba5fc2378ca81bec08ddd3e45860206f325d64f2d58c2ba5a',
     x86_64: '682ba5bd37d140b8dd70f3ce591253cef32fec7652e9ea42c7a5e754519fa13a',
  })

  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
