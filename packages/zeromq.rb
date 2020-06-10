require 'package'

class Zeromq < Package
  description 'Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ.'
  homepage 'https://zeromq.org/'
  version '4.3.2'
  compatibility 'all'
  source_url 'https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz'
  source_sha256 'ebd7b5c830d6428956b67a0454a7f8cbed1de74b3b01e5c33c5378e22740f763'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.3.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '203bef19128bd37bb9320c1413693edaad122804276cb3114e540ab0a77dae3f',
     armv7l: '203bef19128bd37bb9320c1413693edaad122804276cb3114e540ab0a77dae3f',
       i686: '9695e614855a6edb5d0c5ac190ee4dbd6b49dccd6f235f9bc93ffcc70f0e4f9f',
     x86_64: '531fbc84e6d4d4572ae1b4e5e5e84ca63303151d9674cc0e0f79edece7a27d51',
  })

  depends_on 'libunwind'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking'
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
