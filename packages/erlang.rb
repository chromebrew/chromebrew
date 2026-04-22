require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.4.3'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e6fcae0373f4c4a72b384c87942ecac64480f867b419462776c11dce8321afa',
     armv7l: '3e6fcae0373f4c4a72b384c87942ecac64480f867b419462776c11dce8321afa',
     x86_64: '6d8ea1c20c79dd43188b79aa6e275d01bbf293d7f8a3a4eeb04a18de67351eec'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :build
  depends_on 'glibc' => :library
  depends_on 'libglu' => :build
  depends_on 'openssl' => :library
  depends_on 'unixodbc' => :library
  depends_on 'wxwidgets' => :build
  depends_on 'zlib' => :library

  autotools_configure_options "ERL_OTP=#{Dir.pwd} #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
