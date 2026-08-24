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
    aarch64: '9af06b0894554939781f2f02da73eff7e96ebdfe69c2591b8515a60b8762547b',
     armv7l: '9af06b0894554939781f2f02da73eff7e96ebdfe69c2591b8515a60b8762547b',
       i686: '66dca481d52e25ebd6ae5be10aa188649ff426b6aa51b961e4ec335dea13ca08',
     x86_64: 'b624917fef01972cc4d2ac72f15d673535eca1c04ea60994e941e3f822f479f6'
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
