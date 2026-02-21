require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.3.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1d6e748380ffd4a69cd9b33ee1564fececb64252aa3b37a218491f4fb0852b9',
     armv7l: 'b1d6e748380ffd4a69cd9b33ee1564fececb64252aa3b37a218491f4fb0852b9',
     x86_64: '619e1b430676851aefaa95ad5b423a5857b23d63e75d41614a8a1f3ff2c0c8be'
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
