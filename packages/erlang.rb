require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.3.3'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebb18ea28fb9ff046da53b194ebf78c255bd05634dd7c78a85bc1ef2a6d2eb45',
     armv7l: 'ebb18ea28fb9ff046da53b194ebf78c255bd05634dd7c78a85bc1ef2a6d2eb45',
     x86_64: 'a07cb55b48977f39c4269b5e1b94abc132cda80511e29b8877731994b299b5a0'
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
