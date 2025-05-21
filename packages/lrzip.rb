# Adapted from Arch Linux lrzip PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/lrzip/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/autotools'

class Lrzip < Autotools
  description 'Multi-threaded compression with rzip/lzma, lzo, and zpaq'
  homepage 'https://github.com/ckolivas/lrzip'
  version '0.651-1242aec'
  license 'GPL'
  compatibility 'all'
  source_url 'https://github.com/ckolivas/lrzip.git'
  git_hashtag '1242aecfed4c8f10b52204d66e2daafcc53f92ac'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '206babaa1900a768911b8c592876233afe4e2ac478228cd393aa78ca10aac1a4',
     armv7l: '206babaa1900a768911b8c592876233afe4e2ac478228cd393aa78ca10aac1a4',
       i686: '10452825c0b56fe013cdb217a24b2f0cf2eef9eafabfa120644b961f07c1b09c',
     x86_64: 'd429d68035f3fb70e43d6fff77acd6819576abeff0fce1150d63e9b107ea72fe'
  })

  depends_on 'bzip2' # R
  depends_on 'gcc_lib' # R
  depends_on 'lz4' # R
  depends_on 'lzo' # R
  depends_on 'zlib' # R

  git_fetchtags
end
