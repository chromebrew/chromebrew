require 'buildsystems/autotools'

class Cbase < Autotools
  description 'cbase is a C library of useful functions that simplify systems software development on System V UNIX.'
  homepage 'https://www.hyperrealm.com/oss_cbase.shtml'
  version '1.4'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hyperrealm/cbase.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'expat'
end
