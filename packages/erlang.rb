require 'buildsystems/autotools'

class Erlang < Autotools
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'https://www.erlang.org/'
  version '28.3'
  license 'Apache-2.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/erlang/otp.git'
  git_hashtag "OTP-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b4338cbdf5d5dd5ad79e1fc27aa155a9a9731c76ef7eefaa4bac53790f56ba9',
     armv7l: '4b4338cbdf5d5dd5ad79e1fc27aa155a9a9731c76ef7eefaa4bac53790f56ba9',
     x86_64: '2d246585e138fe16ead3bbdd46f4c82dca209a9af3556442968b7a492a0f1a9b'
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
