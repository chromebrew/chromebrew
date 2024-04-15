require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '25.1.2'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/erlang/otp/releases/download/OTP-25.1.2/otp_src_25.1.2.tar.gz'
  source_sha256 '5442dea694e7555d479d80bc81f1428020639c258f8e40b2052732d1cc95cca5'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d11d08a183a483705243ac119c22c5beda2198a379680c70cadb6fab5e178bb',
     armv7l: '5d11d08a183a483705243ac119c22c5beda2198a379680c70cadb6fab5e178bb',
     x86_64: '22d0017e5f52884785b60ee4b866ef357b54e416e2162f7747b82778a0aa703a'
  })

  depends_on 'openjdk8'
  depends_on 'wxwidgets'

  def self.build
    ENV['ERL_OTP'] = Dir.pwd
    system "./configure #{CREW_OPTIONS} && make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
