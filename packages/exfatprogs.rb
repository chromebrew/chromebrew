require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.4.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '508688db5f681d7ccff94942948ca1a12b7141a38afcfe15a6b53e1f25b820ba',
     armv7l: '508688db5f681d7ccff94942948ca1a12b7141a38afcfe15a6b53e1f25b820ba',
       i686: '15e4b329cb44382317a9b2ee349bed6c155f59eaf88b8e726e24a8ddcae50392',
     x86_64: '2548241bc0d073e5f2465e05f1a547f114c642bc58d4a0fb22fe239c49e20c23'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'util_linux' => :executable
end
