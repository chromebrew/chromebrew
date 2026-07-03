require 'buildsystems/autotools'

class Ragel < Autotools
  description 'Compiles finite state machines from regular languages into executable C, C++, Objective-C, or D code.'
  homepage 'https://www.colm.net/open-source/ragel/'
  version '7.1.0-pre.1-b6a727b'
  license 'GPL-2.0-only'
  compatibility 'all'
  source_url 'https://github.com/adrian-thurston/colm-suite.git'
  git_hashtag 'b6a727beb458a06f31d8ce53bd592915bbd98eff'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa958a5c84b74dfbf38521acdbf3243abcd22567cfd92fb9bad85a3362b58cf0',
     armv7l: 'aa958a5c84b74dfbf38521acdbf3243abcd22567cfd92fb9bad85a3362b58cf0',
       i686: '423854b61b56c77d9b57c7e1c5d37450c866068cd3fa97b1d8b0aa77e8adc374',
     x86_64: '2624da1a1ae5f5c51d678c435fab01245e109cfb5cfef0d16c496180cf1769f2'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
