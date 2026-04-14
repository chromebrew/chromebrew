require 'buildsystems/autotools'

class Btrfs_progs < Autotools
  description 'BTRFS is a modern copy on write filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration.'
  homepage 'https://btrfs.readthedocs.io/en/latest/'
  version '6.19.1'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/kdave/btrfs-progs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '110813d0c17f56cb6e0d58b404d756bcce56cb8b5c986abfc29c1028069cb30f',
     armv7l: '110813d0c17f56cb6e0d58b404d756bcce56cb8b5c986abfc29c1028069cb30f',
     x86_64: '4bd86d3a76d2c747dc22d0466cc6fd5b011738ff06253b186a1157ce298004a7'
  })

  depends_on 'e2fsprogs'
  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libgcrypt' => :library
  depends_on 'libsodium' => :library
  depends_on 'libudev_stub' => :library
  depends_on 'libuuid' => :library
  depends_on 'lzo' => :executable
  depends_on 'util_linux' => :library
  depends_on 'vdev' => :library
  depends_on 'zlib' => :executable
  depends_on 'zstd' => :executable

  autotools_configure_options '--disable-documentation \
    --disable-convert \
    --with-crypto=libgcrypt \
    --with-convert=ext2'
end
