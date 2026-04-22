require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.11.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9531dc4ab3deb085321d7cf19a1506d94c04876225983846f110c43c973abcb1',
     armv7l: '9531dc4ab3deb085321d7cf19a1506d94c04876225983846f110c43c973abcb1',
       i686: '6e0b4502ed179f7f390274ecce0d95df51d38598776773cb7018036600872a63',
     x86_64: 'e66a77d887e519bd966c343d953e17c2b76e1f369642f58c285ba46b6d2d79fe'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
