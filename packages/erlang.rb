require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '29.0.3'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1274f6c4b2a1a4de5bd05fe168954da31b6d935a296b499ba8a90e2a0f35614',
     armv7l: 'c1274f6c4b2a1a4de5bd05fe168954da31b6d935a296b499ba8a90e2a0f35614',
     x86_64: 'b635e05520b049cf4176900e940c676e26f8fbe2d654db1daf4d2037e21ee898'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglu' => :build
  depends_on 'ncurses' => :library
  depends_on 'openssl' => :library
  depends_on 'unixodbc' => :library
  depends_on 'wxwidgets' => :build
  depends_on 'zlib' => :library

  autotools_configure_options "ERL_OTP=#{Dir.pwd} #{'--disable-year2038' unless ARCH.eql?('x86_64')}"
end
