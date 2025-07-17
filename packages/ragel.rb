require 'buildsystems/autotools'

class Ragel < Autotools
  description 'Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '6.10'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url 'https://www.colm.net/files/ragel/ragel-6.10.tar.gz'
  source_sha256 '5f156edb65d20b856d638dd9ee2dfb43285914d9aa2b6ec779dac0270cd56c3f'
  binary_compression 'tar.zst'

  binary_sha256({
     x86_64: '8fa3f5222ebecb84cecd0b936c42697f4a57614d193e773bc36296b583f74132'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  autotools_pre_configure_options "CFLAGS+=' -std=gnu++98' CXXFLAGS+=' -std=gnu++98'"
end
