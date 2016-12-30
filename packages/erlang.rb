require 'package'

class Erlang < Package
  version '19.2'
  source_url 'http://www.erlang.org/download/otp_src_19.2.tar.gz'
  source_sha1 'f5188ba6f496b9d1c37597705d095b4e6aa7bcd3'

  def self.build
    system 'export ERL_OTP=`pwd`'
    system './configure --prefix=/usr/local'
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
