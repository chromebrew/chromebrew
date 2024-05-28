require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '27.0'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0df239e644449e6611cac6b31411b70018633682f314991179db6addcb4407d5',
     armv7l: '0df239e644449e6611cac6b31411b70018633682f314991179db6addcb4407d5',
     x86_64: '3cf4d3e96f1acc8a067792c3f8b016a919c0636c7c52a0db873fd19a8f0e6ffb'
  })

  depends_on 'openjdk8'
  depends_on 'wxwidgets'

  year2038 = ARCH == 'x86_64' ? '' : '--disable-year2038'

  configure_options "ERL_OTP=#{Dir.pwd} #{year2038}"
end
