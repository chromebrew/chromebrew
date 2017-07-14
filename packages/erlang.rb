require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '19.2'
  source_url 'http://www.erlang.org/download/otp_src_19.2.tar.gz'
  source_sha256 'a016b3ef5dac1e532972617b2715ef187ecb616f7cd7ddcfe0f1d502f5d24870'

  def self.build
    system 'export ERL_OTP=`pwd`'
    system './configure --prefix=/usr/local'
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
