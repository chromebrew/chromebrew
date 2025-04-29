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
       i686: 'd518a6e7e4cc41244c947a289ef2071e2fe5ecf1b51f0c7f0ff973106352d2cf',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'expat'
  depends_on 'e2fsprogs' # R
  depends_on 'glibc' # R
  depends_on 'krb5' # R
  depends_on 'libtirpc' # R
end
