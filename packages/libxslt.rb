require 'buildsystems/cmake'

class Libxslt < CMake
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'https://gitlab.gnome.org/GNOME/libxslt/-/wikis/home'
  version "1.1.45-#{CREW_ICU_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libxslt.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a06d2e6fc1730baacfb7740d55b40fb94626e37bf2e2a9adb3e6973aea83113',
     armv7l: '0a06d2e6fc1730baacfb7740d55b40fb94626e37bf2e2a9adb3e6973aea83113',
       i686: '087b6af2a48540a3c9eded8ad35a81867dfe57ae78bd894841a3d4cec08e9a09',
     x86_64: '9aaf57c2d0dd896191f4f923aa1a1753ae84cdfeacc55e392d6fbd18c7b20dd7'
  })

  depends_on 'docbook_xml' => :build
  depends_on 'glibc' # R
  depends_on 'libxml2' # R

  cmake_options '-DLIBXSLT_WITH_PYTHON=OFF'
end
