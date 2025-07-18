require 'buildsystems/cmake'

class Libxslt < CMake
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxslt/-/wikis/home'
  version "1.1.43-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxslt.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40748afecc8696402de5533baf624e18c2cdeae4a7b38b3684f9c70efec9a254',
     armv7l: '40748afecc8696402de5533baf624e18c2cdeae4a7b38b3684f9c70efec9a254',
       i686: '41b288c62c3a93ea29f8d29bce5e301bb82758b4e8e2b0a7fe989c0ee5aaf0c5',
     x86_64: '47492528964514cce1facb4df837b1ebe68864f7a7a832bee5b6f83653fb8e45'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'glibc' # R
  depends_on 'libxml2' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
