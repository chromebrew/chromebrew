require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '29.0.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b0e87f134afc3fbf24f6fd781bf3639b7f34d97c08af3cd86cefa0458d119dc',
     armv7l: '8b0e87f134afc3fbf24f6fd781bf3639b7f34d97c08af3cd86cefa0458d119dc',
     x86_64: 'cc61182cf3ada008846bf383458a4151f00d3567221d5920c66bd20a9e3c43a1'
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
