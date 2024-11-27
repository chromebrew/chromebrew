require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.45.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c55fe9b36738d9969e10d24182c8797513506ed931950d1bd507c0148eb34ba',
     armv7l: '4c55fe9b36738d9969e10d24182c8797513506ed931950d1bd507c0148eb34ba',
       i686: '5fa9f4979d0bf1f65843b9830331e1f81acadec2a4b07707863238688dde069b',
     x86_64: '13166c0f2728ae383d3e4769546efa6c016d8a2247e231007c489d81d1588605'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
