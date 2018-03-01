require 'package'

class Libevent < Package
  description 'The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached.'
  homepage 'http://libevent.org/'
  version '2.1.8'
  source_url 'https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz'
  source_sha256 '965cc5a8bb46ce4199a47e9b2c9e1cae3b137e8356ffdad6d94d3b9069b71dc2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libevent-2.1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '58136d747807fe1085e9747f3b60354dca52f85c37e2fbcf4a40b41b9a3da33f',
     armv7l: '58136d747807fe1085e9747f3b60354dca52f85c37e2fbcf4a40b41b9a3da33f',
       i686: '85dd3103701457da5bedbcf5c67b0c94f20c55df5246db2477752c4c11853178',
     x86_64: 'cf291ce1a40868aa652a3ab048335013ccbe586552d1734d27b2807ceec8821b',
  })
  depends_on 'openssl'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
