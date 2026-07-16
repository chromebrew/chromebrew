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
    aarch64: '898b8891f1fc1e73da16d96b51a12e71f818f87b63921f2cf7569d8fb12df4ef',
     armv7l: '898b8891f1fc1e73da16d96b51a12e71f818f87b63921f2cf7569d8fb12df4ef',
     x86_64: 'ccc85388f30f4b426bd8df864e93b52c55717e9087f1acf86b28932a37307835'
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
