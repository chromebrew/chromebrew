require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '27.0.1'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e217ec9ee6e3603b264bb551543ae204e7790c7b370213d049e7ce92f59f4463',
     armv7l: 'e217ec9ee6e3603b264bb551543ae204e7790c7b370213d049e7ce92f59f4463',
     x86_64: 'bdcbe7622352f10703b073311deabeaf9fb2994b49e945e7667373ff56da3866'
  })

  depends_on 'openjdk8'
  depends_on 'wxwidgets'

  configure_options "ERL_OTP=#{Dir.pwd} #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
