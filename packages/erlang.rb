require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.0'
  source_url 'http://erlang.org/download/otp_src_20.0.tar.gz'
  source_sha256 'fe80e1e14a2772901be717694bb30ac4e9a07eee0cc7a28988724cbd21476811'

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
