require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.4.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1091f1a86c5d70c2150f3de1f802e338c93a7d5022c131822353b393b0bbeafe',
     armv7l: '1091f1a86c5d70c2150f3de1f802e338c93a7d5022c131822353b393b0bbeafe',
       i686: 'f845d7d9d866e3bfd70f13eb3fe948c7593f70afad6653bb50402b0992320cff',
     x86_64: 'a72639040f5325b08388be0db95e7cf0e000d205fb857d3b47a19ad4fe2abdb7'
  })

  depends_on 'glibc' => :executable
  depends_on 'util_linux' => :executable
end
