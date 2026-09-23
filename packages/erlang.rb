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
    aarch64: '29ee8219af913b5feb177b71c513df259d515ec004ca51a5b8c9f5a172e2be96',
     armv7l: '29ee8219af913b5feb177b71c513df259d515ec004ca51a5b8c9f5a172e2be96',
     x86_64: 'df66803fc6b6d755e8707bb48273cf475bdfae9cd6bf70ec9377ed2353ed6bb4'
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
