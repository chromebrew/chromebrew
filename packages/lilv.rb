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
    aarch64: '078d82716b0548f70f782329a0d227c9d0d081a6253b43bc217c93effa675628',
     armv7l: '078d82716b0548f70f782329a0d227c9d0d081a6253b43bc217c93effa675628',
       i686: '811332266a881a587df19a645752010d8e4ca2aaa00fe5329baa72b2e9d5530a',
     x86_64: 'd562b0d72026d93c91f04d42d02290781e85e65cf2f7729dbfcddb68751c095b'
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
