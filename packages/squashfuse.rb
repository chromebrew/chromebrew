# Adapted from Arch Linux squashfuse PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/squashfuse/trunk/PKGBUILD

require 'buildsystems/autotools'

class Squashfuse < Autotools
  description 'FUSE filesystem to mount squashfs archives'
  homepage 'https://github.com/vasi/squashfuse'
  version '0.6.3'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/vasi/squashfuse.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '630de64705eb85ebba47e9c6129b30961aaf3401ae18b6ae9cc39f8bc1fff19a',
     armv7l: '630de64705eb85ebba47e9c6129b30961aaf3401ae18b6ae9cc39f8bc1fff19a',
       i686: 'abe55a32f765ab8f01c81ebac41544f19f2c523c64e48930b1dd81be74f02139',
     x86_64: '70c35249171db95ef55b6dc7d7e8b64fba99c6edc11d9774a6d19e313b7acbea'
  })

  depends_on 'fuse3' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lz4' => :library
  depends_on 'lzo' => :library
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library
end
