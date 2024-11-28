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
    aarch64: '73beb681a089d0df685e40ec26eab2ae8043af6f6f351a7bd206443830a074f3',
     armv7l: '73beb681a089d0df685e40ec26eab2ae8043af6f6f351a7bd206443830a074f3',
       i686: 'b2dd37e2b8d40769a9f8983139986c708d3d126d8fa1dbdb5102775bb285c4c8',
     x86_64: '7965e4b86df1ab7e10463700735cc8c0443a678b66904b4f3458e1989fa89b0b'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
