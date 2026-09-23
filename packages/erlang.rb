require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '29.1.1'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c44ac66a0c35be028b9c7e4a2edcf34fff31e01768139d70dc741b14466dc5d',
     armv7l: '6c44ac66a0c35be028b9c7e4a2edcf34fff31e01768139d70dc741b14466dc5d',
     x86_64: '954f6f6a496ab3db3edb3d2747c6c468d192d145892ff0d9f3379632842b8851'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglu' => :build
  depends_on 'ncurses' => :library
  depends_on 'openjdk17' => :executable
  depends_on 'openssl' => :library
  depends_on 'unixodbc' => :library
  depends_on 'wxwidgets' => :build
  depends_on 'zlib' => :library

  autotools_configure_options "ERL_OTP=#{Dir.pwd} #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
