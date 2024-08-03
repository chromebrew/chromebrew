require 'buildsystems/cmake'

class Libxslt < CMake
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxslt/-/wikis/home'
  version '1.1.42'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxslt.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1aa45b119290663ec6bccf541425e47294ea0117bec4f830b2d82d44fb5ec078',
     armv7l: '1aa45b119290663ec6bccf541425e47294ea0117bec4f830b2d82d44fb5ec078',
       i686: '7dfbfd500ba728ae0a55a41293e5b6ed202edf5948c3b31fd6ee335177f73423',
     x86_64: 'af7874aa559a2c665c6755c12b04658bc70e2a1c6641194caea58b8267c8156d'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libxml2' # R
  depends_on 'icu4c' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
