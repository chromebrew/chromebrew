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
    aarch64: '7fd36a5455ade3ab19e3248f4efafe4d2cf40729494b6800fa13f2f7cc792c72',
     armv7l: '7fd36a5455ade3ab19e3248f4efafe4d2cf40729494b6800fa13f2f7cc792c72',
       i686: 'f8c7eb6ada8b628ede3a904e47cf4b58619af770045b241f6c121b0194e97fcf',
     x86_64: '84dcb3813c0197bb8284b0d8915d4d17440c4626b52d2c010552f32c8a71bf38'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libxml2' # R
  depends_on 'icu4c' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
