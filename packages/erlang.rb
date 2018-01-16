require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.2'
  source_url 'http://erlang.org/download/otp_src_20.2.tar.gz'
  source_sha256 '24d9895e84b800bf0145d6b3042c2f2087eb31780a4a45565206844b41eb8f23'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'flex' => :build
  depends_on 'automake' => :build
  depends_on 'util_linux' => :build
  depends_on 'm4' => :build

  def self.build
    system 'export ERL_OTP=`pwd`'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
