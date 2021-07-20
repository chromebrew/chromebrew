require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '24.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'http://erlang.org/download/otp_src_24.0.tar.gz'
  source_sha256 '27cb5d62f82778793f96b67dbc0c67aa490267274e2f06efee8111ef11c4755c'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/24.0_armv7l/erlang-24.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/24.0_armv7l/erlang-24.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/24.0_i686/erlang-24.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/erlang/24.0_x86_64/erlang-24.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1049d788c19d7a187a09e4e80c5128e9173213ed453be9c789d3d7cadc5cee1f',
     armv7l: '1049d788c19d7a187a09e4e80c5128e9173213ed453be9c789d3d7cadc5cee1f',
       i686: 'e0fb17559d68b7ade5fc66fad22ed88eaee3ef3b34277ecd5416ed14d6f7c33b',
     x86_64: 'd6b25b877e2217536d6cca2bd6464d95f97c43df4b73546e150e0cd04ed6bf38',
  })

  depends_on 'jdk8'
  depends_on 'wxwidgets'

  def self.build
    system "export ERL_OTP=`pwd` && ./configure #{CREW_OPTIONS} && make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
