require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '29.0.6'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1d9b283d515bddeb91d38f27943b95842075fede8e69629546feb5e7f273752',
     armv7l: 'c1d9b283d515bddeb91d38f27943b95842075fede8e69629546feb5e7f273752',
     x86_64: '8d36e7da3697bcf52c8c9e95dbc4249198b7b5ca8a84f2db1703efd7e2a7a14c'
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
