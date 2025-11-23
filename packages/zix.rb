# Adapted from Arch Linux zix PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/zix/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/meson'

class Zix < Meson
  description 'A lightweight C99 portability and data structure library'
  homepage 'https://gitlab.com/drobilla/zix'
  version '0.8.0'
  license '0BSD OR ISC'
  compatibility 'all'
  source_url 'https://gitlab.com/drobilla/zix.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53fcab8ea102cde913a61df8fde58198f3d69095a8f70689c5f91d9a1f9b3d14',
     armv7l: '53fcab8ea102cde913a61df8fde58198f3d69095a8f70689c5f91d9a1f9b3d14',
       i686: '4cece6cdbf6d5b79a1892fbc379c6110aa0a9ab252b5358d31a5d1e8740507d5',
     x86_64: '8ab8cedd9c499bc5cbe9a1845050857d8485ef3bb44dade7b3b106fccbaabb4a'
  })

  depends_on 'glibc' # R
end
