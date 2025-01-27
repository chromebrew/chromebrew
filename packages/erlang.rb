require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '27.2.1'
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed0d27601c42358b0dccb215893944b19944868853a32bff415979efb28b147b',
     armv7l: 'ed0d27601c42358b0dccb215893944b19944868853a32bff415979efb28b147b',
     x86_64: '7ca0591339f5de81daf0181df104db5974d7f13c0177bace0571cf306b07b00b'
  })

  depends_on 'openjdk8'
  depends_on 'wxwidgets'
  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libglu' # R
  depends_on 'libglvnd' # R
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'unixodbc' # R
  depends_on 'zlib' # R

  configure_options "ERL_OTP=#{Dir.pwd} #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
