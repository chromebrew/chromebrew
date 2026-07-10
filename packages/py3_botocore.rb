require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.45-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3465242f995c623f2718d6bf21eec2c600ce1636436628f3d3f810a7212fbec',
     armv7l: 'c3465242f995c623f2718d6bf21eec2c600ce1636436628f3d3f810a7212fbec',
       i686: '6e2f3e60eb12e7abcb1ff828ebc07438c2ea9658d223ee1fd9d065842f5fabf3',
     x86_64: 'f13fef562895dea56ff5355cb0771e8066d0151ff08992387c0870bd165b078d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
