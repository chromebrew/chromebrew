require 'buildsystems/autotools'

class Btrfs_progs < Autotools
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.readthedocs.io/en/latest/'
  version '7.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kdave/btrfs-progs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad8fa8a6eebc641abfbe7b830c4c75b690d8f0cb89c8f7f5225ca5c176303e42',
     armv7l: 'ad8fa8a6eebc641abfbe7b830c4c75b690d8f0cb89c8f7f5225ca5c176303e42',
     x86_64: 'bdc6b814c42065e19b3f795dd1ab43bdcebd4c504ca0ac7dcc1593db2a5fd49e'
  })

  depends_on 'e2fsprogs'
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
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
