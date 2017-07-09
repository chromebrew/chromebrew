require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.0'
  source_url 'http://erlang.org/download/otp_src_20.0.tar.gz'
  source_sha256 'fe80e1e14a2772901be717694bb30ac4e9a07eee0cc7a28988724cbd21476811'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/erlang-20.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/erlang-20.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/erlang-20.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/erlang-20.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dc606a55efaa490551c47a57d40f5eb57f5d9e7e7cc4f1e5ed315d9ea81dfcec',
     armv7l: 'dc606a55efaa490551c47a57d40f5eb57f5d9e7e7cc4f1e5ed315d9ea81dfcec',
       i686: 'cd06eacaa56bba7fd3ec72840f5e6e1c9e893684837b8af2b889832a212c539d',
     x86_64: '807f78fae8ec997e891a443f982ccad5820b42777ec6c7020660a89597e4d368',
  })

  depends_on 'flex' => :build

  def self.build
    system 'export ERL_OTP=`pwd`'
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
