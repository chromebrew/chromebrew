require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '23.1'
  compatibility 'all'
  source_url 'http://erlang.org/download/otp_src_23.1.tar.gz'
  source_sha256 'cb5b7246eeaac9298c51c9915386df2f784e82a3f7ff93b68453591f0b370400'

  binary_url ({
    
  })
  binary_sha256 ({
    
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
