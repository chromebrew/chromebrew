require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.4.2'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfa9b5ead57d191669bcca028ab5eec29959768d96c738d5b5a38371ccc87ee2',
     armv7l: 'cfa9b5ead57d191669bcca028ab5eec29959768d96c738d5b5a38371ccc87ee2',
     x86_64: 'bfc23b3e0b2fde61347da364598b33b913eca84312b0416ca333b7c51be66cd5'
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
