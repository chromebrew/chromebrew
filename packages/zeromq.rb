require 'package'

class Zeromq < Package
  description 'Fast messaging system built on sockets. C and C++ bindings. aka 0MQ, ZMQ.'
  homepage 'http://zeromq.org/'
  version '4.2.2'
  source_url 'https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz'
  source_sha256 '5b23f4ca9ef545d5bd3af55d305765e3ee06b986263b31967435d285a3e6df6b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/zeromq-4.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9153ad8e7f6ec0b271b3dc7ab83469315727f674b0b9fa40608d6f1acafee21a',
     armv7l: '9153ad8e7f6ec0b271b3dc7ab83469315727f674b0b9fa40608d6f1acafee21a',
       i686: 'ce518f73155b3036ebf97f64fe9d62e1820f610dcb17524303c1027cbcac1c32',
     x86_64: '6d5a1494e5a90f72e152b737738c9e4949a2e24eae9f10c5561cfecc55263314',
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
