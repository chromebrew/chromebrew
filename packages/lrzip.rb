# Adapted from Arch Linux lrzip PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/lrzip/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/autotools'

class Lrzip < Autotools
  description 'Multi-threaded compression with rzip/lzma, lzo, and zpaq'
  homepage 'https://github.com/ckolivas/lrzip'
  version '0.660'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/ckolivas/lrzip.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '42df7df626bd5307b8c748e99df07a33c9367922942533fc2b329609a1bfceb5',
     armv7l: '42df7df626bd5307b8c748e99df07a33c9367922942533fc2b329609a1bfceb5',
       i686: 'bd559e6b17966b1afa089c020ace82c7ff0f1099238417e6bdb92ec40167c3ab',
     x86_64: '98f85b08add4a133f193c055313dc51f4e0bc9bddbad070b10a31d896e3e65ca'
  })

  depends_on 'bzip2' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'lz4' => :executable
  depends_on 'lzo' => :executable
  depends_on 'zlib' => :executable

  git_fetchtags
end
