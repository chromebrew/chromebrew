require 'package'

class Zeromq < Package
  description 'Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ.'
  homepage 'http://zeromq.org/'
  version '4.2.2'
  source_url 'https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz'
  source_sha256 '5b23f4ca9ef545d5bd3af55d305765e3ee06b986263b31967435d285a3e6df6b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libunwind'
  depends_on 'xzutils'

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
