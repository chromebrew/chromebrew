require 'buildsystems/autotools'

class Btrfs_progs < Autotools
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.readthedocs.io/en/latest/'
  version '7.3'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kdave/btrfs-progs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89330572d11c2fd9ccca1d6e1e917bbbcc83ce5090631ac71840a96537d94eaf',
     armv7l: '89330572d11c2fd9ccca1d6e1e917bbbcc83ce5090631ac71840a96537d94eaf',
     x86_64: '033f7be978b3154b428dad8f588a209a93c87b4c7de90e238038f6e29d33f84b'
  })

  depends_on 'e2fsprogs'
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libsodium' => :library
  depends_on 'libuuid' => :library
  depends_on 'lzo' => :executable
  depends_on 'util_linux' => :library
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-documentation \
    --disable-convert \
    --with-crypto=libgcrypt \
    --with-convert=ext2'
end
