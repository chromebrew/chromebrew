require 'buildsystems/autotools'

class Ragel < Autotools
  description 'Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '7.1.0'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url 'https://github.com/adrian-thurston/colm-suite.git'
  git_hashtag "ragel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23e0eba748596736ea88576590a29f91a12192f5625bf78c5862384c6d35ddea',
     armv7l: '23e0eba748596736ea88576590a29f91a12192f5625bf78c5862384c6d35ddea',
       i686: '000a4eae2a9dc614d51a005aeabbe2042399a6cc9ef49e5e23f209ecbd494185',
     x86_64: '294b92f6c82220e233755ba3a326a5328691057c10e1fffa1d996dd365087074'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
