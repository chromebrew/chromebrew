require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.3'
  compatibility 'all'
  source_url 'http://erlang.org/download/otp_src_20.3.tar.gz'
  source_sha256 '4e19e6c403d5255531c0b870f19511c8b8e3b080618e4f9efcb44d905935b2a1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c11074782368897a2029ef5464d2cba0806cef4722ed73cf729d99635249d53b',
     armv7l: 'c11074782368897a2029ef5464d2cba0806cef4722ed73cf729d99635249d53b',
       i686: '8003cf2eb75ab2bb12babc08b2f5f894ec45a3dd842f377caa8ddcbc4d6be289',
     x86_64: '8d3509fae44a1be086351f6fa97ecfb000c721eab0677316c7dbb7d2a3e96ccb',
  })

  depends_on 'flex' => :build

  def self.build
    system 'export ERL_OTP=`pwd`'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
