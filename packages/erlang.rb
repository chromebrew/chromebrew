require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.5'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '947ce63b33018ac1a4fc19ffc13abb0218cbb9f636a2192b75e287b0c3facc28',
     armv7l: '947ce63b33018ac1a4fc19ffc13abb0218cbb9f636a2192b75e287b0c3facc28',
     x86_64: '03f01ef94fa327b9fa5c501b6249c8a27d19dcae6315f5cf36e601713a4483c8'
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
