require 'buildsystems/autotools'

class Btrfs_progs < Autotools
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.readthedocs.io/en/latest/'
  version '6.17.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kdave/btrfs-progs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '093314c5f1cf6c974bfea1c9980d7fb644850a53d14d2df05d41e499ede93b7a',
     armv7l: '093314c5f1cf6c974bfea1c9980d7fb644850a53d14d2df05d41e499ede93b7a',
     x86_64: 'caa3bfd5d60bae8f3fab608b5bcd5e1ee649eb4c4e5a7152599efcb0c33f2c3d'
  })

  depends_on 'e2fsprogs'
  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'libsodium' # R
  depends_on 'libuuid' # R
  depends_on 'lzo' # R
  depends_on 'util_linux' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

  autotools_configure_options '--disable-documentation \
    --disable-convert \
    --with-crypto=libgcrypt \
    --with-convert=ext2'
end
