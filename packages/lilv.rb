# Adapted from Arch Linux lilv PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/lilv/trunk/PKGBUILD

require 'buildsystems/meson'

class Lilv < Meson
  description 'A C library interface to the LV2 plug-in standard'
  homepage 'https://drobilla.net/software/lilv/'
  version "0.28.0-#{CREW_PY_VER}"
  license 'isc'
  compatibility 'all'
  source_url 'https://github.com/lv2/lilv.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c011d0753138a7927b1577988909389200c9fbcfa0f9efea0c19c7283651c435',
     armv7l: 'c011d0753138a7927b1577988909389200c9fbcfa0f9efea0c19c7283651c435',
       i686: 'f79a50b18ef89cca5ab6e76d9b5c6931ddb513ea9b42de6e36439f5487f684f7',
     x86_64: 'f65e7bea1792c194778177662d5f15b29b5fc7f1b371a07cc3730850a311c69d'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libsndfile' => :executable
  depends_on 'lv2' => :logical
  depends_on 'python3' => :build
  depends_on 'serd' => :library
  depends_on 'sord' => :library
  depends_on 'sratom' => :library
  depends_on 'zix' => :library

  meson_options '-Ddocs=disabled \
               -Dtests=disabled'
end
