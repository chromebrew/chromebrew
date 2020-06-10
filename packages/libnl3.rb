require 'package'

class Libnl3 < Package
  description 'Library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  version '3.2.25-0'
  compatibility 'all'
  source_url 'https://www.infradead.org/~tgr/libnl/files/libnl-3.2.25.tar.gz'
  source_sha256 '8beb7590674957b931de6b7f81c530b85dc7c1ad8fbda015398bc1e8d1ce8ec5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnl3-3.2.25-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fdce1a46f9a89772ef9b51dd5bf738a24966908027299f5c3dc049c95b8f2a7b',
     armv7l: 'fdce1a46f9a89772ef9b51dd5bf738a24966908027299f5c3dc049c95b8f2a7b',
       i686: '1efa9cd106f16ff347d82bb3cb0734d8393d53edf51db2d294e9788a20036bb4',
     x86_64: '4494bd6d1919090838d86f75d6cc1ea86becc467400d58dffc4e905d27a373da',
  })

  def self.build
	system "./configure \
		--prefix=#{CREW_PREFIX} \
		--libdir=#{CREW_LIB_PREFIX} \
                --sysconfdir=#{CREW_PREFIX}/etc \
                --sbindir=#{CREW_PREFIX}/sbin \
                --disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
