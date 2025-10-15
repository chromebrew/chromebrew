require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.3.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f707e6f1519aa495d08f059132215e44709f3d8fd8527bae556dc618c00cf477',
     armv7l: 'f707e6f1519aa495d08f059132215e44709f3d8fd8527bae556dc618c00cf477',
       i686: 'f7b3a9426b7a9f5d2bf8559c9b0e4602d5c5b0696882b38a3d09451ed5f04de9',
     x86_64: '959e41a09ec92ae430c5c0c5485eb5f56cd25d1eab51c867d7d171ee7575d3b9'
  })

  depends_on 'glibc' # R
end
