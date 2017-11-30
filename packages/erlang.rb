require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.1'
  source_url 'http://erlang.org/download/otp_src_20.1.tar.gz'
  source_sha256 '900d35eb563607785a8e27f4b4c03cf6c98b4596028c5d6958569ddde5d4ddbf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf24687d8812ede4cf40d589ef10ca77b3688bb9f80ca98508b4a650140d87b7',
     armv7l: 'bf24687d8812ede4cf40d589ef10ca77b3688bb9f80ca98508b4a650140d87b7',
       i686: '4621102a3c46a60e71d204394b6fc8304ca75772cca7bbabbe268ef3efa63776',
     x86_64: '288b9aeae32d800ccf6bd82a3fa54ecbf20d523e206c356bb7441264fe81db83',
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
