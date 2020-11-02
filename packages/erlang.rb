require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '23.1'
  compatibility 'all'
  source_url 'http://erlang.org/download/otp_src_23.1.tar.gz'
  source_sha256 'cb5b7246eeaac9298c51c9915386df2f784e82a3f7ff93b68453591f0b370400'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-23.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-23.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-23.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-23.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '22823fe62be5afe6a98a06061b6ca2b6f7138d3bb20a3730593aa3defa42f29b',
     armv7l: '22823fe62be5afe6a98a06061b6ca2b6f7138d3bb20a3730593aa3defa42f29b',
       i686: '7a743f66c1a0068e82d83cc24f58572e4b7668afc1635ff4dc6d83a0b76de678',
     x86_64: 'c0f06d37f7f3a0ba6d600dec48a1dd668c16d602333ea587030b6c5e333d139a',
  })

  depends_on 'flex' => :build

  def self.build
    system 'export ERL_OTP=`pwd`'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
