require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.3.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8f7504081e2f18f00bfddc3420b1de84d189628994e61847840c76b76698fbe',
     armv7l: 'd8f7504081e2f18f00bfddc3420b1de84d189628994e61847840c76b76698fbe',
       i686: 'cd409f831c754d9f6dedd9736a5df6bf9db317f678447dd136c21207208fcdb3',
     x86_64: 'c2b37dbe978808a8b0d12f9392c13e4f72c76a1141ca6d9d0b4324e5f2c89be3'
  })

  depends_on 'glibc' # R
end
