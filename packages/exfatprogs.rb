require 'buildsystems/autotools'

class Exfatprogs < Autotools
  description 'exFAT filesystem userspace utilities for the Linux Kernel exfat driver.'
  homepage 'https://github.com/exfatprogs/exfatprogs'
  version '1.4.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/exfatprogs/exfatprogs.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5ac71aca6d70c6cf33ca5209cb404c13d1752b89f72996bc2c5aa475aca2dc0b',
     armv7l: '5ac71aca6d70c6cf33ca5209cb404c13d1752b89f72996bc2c5aa475aca2dc0b',
       i686: '04affac59a8073de7780377b4e581a74f05e02b13baa775f8b2992469195b179',
     x86_64: '00cacfd49ca3889ca0e723b94440d47f183153ce6c5c829ec4797c8b07c616df'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'util_linux' => :executable
end
