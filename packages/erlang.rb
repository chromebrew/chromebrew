require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.1.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0f2a93355ad7f7a9fdebd6e2cb7c099d89e1f8abd2dab05ddf470258d6fea914',
     armv7l: '0f2a93355ad7f7a9fdebd6e2cb7c099d89e1f8abd2dab05ddf470258d6fea914',
     x86_64: 'ed314f0181934c9e29c70b15f97bc9d7ede13bf29ca954afe2aaff581af9103d'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libglu' # R
  depends_on 'openssl' # R
  depends_on 'unixodbc' # R
  depends_on 'wxwidgets' # R
  depends_on 'zlib' # R

  autotools_configure_options "ERL_OTP=#{Dir.pwd} #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
