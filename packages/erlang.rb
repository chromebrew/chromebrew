require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.3.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6aa440b1db8709a6ebec1462f76bc4a6865d36e23d1702485753b41416dd176',
     armv7l: 'b6aa440b1db8709a6ebec1462f76bc4a6865d36e23d1702485753b41416dd176',
     x86_64: 'b370d2fc94a6727ab6731df9767594b7463888e210d3a3e8b9e8ca1b94272ad5'
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
