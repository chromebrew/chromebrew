require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.1'
  source_url 'http://erlang.org/download/otp_src_20.1.tar.gz'
  source_sha256 '900d35eb563607785a8e27f4b4c03cf6c98b4596028c5d6958569ddde5d4ddbf'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'flex' => :build

  def self.build
    system 'export ERL_OTP=`pwd`'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
