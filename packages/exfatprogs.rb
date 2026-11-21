require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.4.5'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e809bac73e8f3b8213c052fea2f6fb76c42aade80a06756678f3dc5278870d8d',
     armv7l: 'e809bac73e8f3b8213c052fea2f6fb76c42aade80a06756678f3dc5278870d8d',
       i686: '390f7bfca7f685b2a66ded72224da6162b4f27caa4a03fc51004100a61f4bace',
     x86_64: 'd61677e05d2f4dcab310698b8815c5a9d59897d8a077e0467a111168da662edb'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'util_linux' => :executable
end
