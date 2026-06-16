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
    aarch64: '845e59aa8521d83d0206e899d11ffe9f8fb9daf00557632440f663fcc7f433e8',
     armv7l: '845e59aa8521d83d0206e899d11ffe9f8fb9daf00557632440f663fcc7f433e8',
       i686: '25bdb6a28991fb975a6d9b4076eb01161187db0557fd3bc6cbffe2c42a7d7c96',
     x86_64: 'f355404dd24fe3a35c8d9911ec90a743f3ee3892076da9fb1c61e494d87849c3'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'util_linux' => :executable
end
