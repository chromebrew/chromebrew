require 'package'

class Erlang < Package
  version '19.0'
  source_url 'http://www.erlang.org/download/otp_src_19.0.tar.gz'
  source_sha1 '3be958b529de4be19d77eb77f587a76210b43bfd'

  def self.build
    system 'export ERL_OTP=`pwd`'
    system './configure --prefix=/usr/local'
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
