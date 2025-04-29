require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5aad16926c807ee221b366f4b7d1376214ba9dde0f4c619240ceb48f54c94048',
     armv7l: '5aad16926c807ee221b366f4b7d1376214ba9dde0f4c619240ceb48f54c94048',
       i686: 'aef059dd9a9ed228cb6bd775a21dd197298ba51422061bc9fbfdc46178edd49f',
     x86_64: 'e64eedcefd6bbbd517cd68b44f5e912492128c874559e5cbd33a6794f750ff70'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
