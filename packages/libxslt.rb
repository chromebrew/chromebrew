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
    aarch64: '79a84b35213937c568b715b859049a1d4555f989ba1379a7328e106c385ea502',
     armv7l: '79a84b35213937c568b715b859049a1d4555f989ba1379a7328e106c385ea502',
       i686: '086d2c221318809d333c9424ee7714843975ecedab93efd2b7fed3254cc0b731',
     x86_64: '57ea96a35e54f1c0c26645e847e1ccfdef098ab0a6fa86f825748f0817e1a010'
  })

  depends_on 'docbook_xsl' => :build
  depends_on 'glibc' # R
  depends_on 'libgcrypt' # R
  depends_on 'libgpg_error' # R
  depends_on 'libxml2' # R
  depends_on 'icu4c' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
