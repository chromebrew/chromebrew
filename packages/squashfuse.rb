# Adapted from Arch Linux squashfuse PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/squashfuse/trunk/PKGBUILD

require 'buildsystems/autotools'

class Squashfuse < Autotools
  description 'FUSE filesystem to mount squashfs archives'
  homepage 'https://github.com/vasi/squashfuse'
  version '0.6.5'
  license 'custom'
  compatibility 'all'
  source_url 'https://github.com/vasi/squashfuse.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '311d49828624fd0b1e3c75452e0b3885324c22e9b8e7f708e8de7139f7d25f96',
     armv7l: '311d49828624fd0b1e3c75452e0b3885324c22e9b8e7f708e8de7139f7d25f96',
       i686: 'fb734a0053cd691a93bff1998bd7bf16b9a1678526d96185d1f116757a559aeb',
     x86_64: '56622cfdff628bf648a3df40e0f412eeadc1d0aeb894f88f0c24ad03ec843278'
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
