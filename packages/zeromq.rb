require 'package'

class Zeromq < Package
  description 'Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ.'
  homepage 'https://zeromq.org/'
  version '4.3.2'
  source_url 'https://github.com/zeromq/libzmq/releases/download/v4.3.2/zeromq-4.3.2.tar.gz'
  source_sha256 'ebd7b5c830d6428956b67a0454a7f8cbed1de74b3b01e5c33c5378e22740f763'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libunwind'

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "--disable-dependency-tracking"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
