require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.4.4'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36eb9dd25f3124dbe3422ce11d720cb0ef1a97cd142b413a63d900b788f7b408',
     armv7l: '36eb9dd25f3124dbe3422ce11d720cb0ef1a97cd142b413a63d900b788f7b408',
       i686: 'bfc4a7146e1a6ea3580c68c7440c71476a3b4078ffdeba4063691eeb1d727309',
     x86_64: 'ff1fd10c35423750d99d1d07cc8eeb7646ee67e01bbe937f4b8e3fa1ef924a74'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'util_linux' => :executable
end
