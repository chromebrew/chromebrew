require 'buildsystems/pip'

class Py3_pyte < Pip
  description 'PyTE is a Simple VTXXX-compatible terminal emulator.'
  homepage 'https://github.com/selectel/pyte/'
  version "0.8.2-#{CREW_PY_VER}"
  license 'LGPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0e470f9ee2ed2378752f0b12d3581da70f6f15927e24d01dd1d4c873f6693019',
     armv7l: '0e470f9ee2ed2378752f0b12d3581da70f6f15927e24d01dd1d4c873f6693019',
       i686: '0f791907683662ec2fe4cdf87f14d600b853d987927dbace4b45e0359414bb5c',
     x86_64: '7ffc9c40bc283433367d158ae2b65e4fc1e1a8c7593b372f49550e5faae45313'
  })

  depends_on 'py3_wcwidth'
  depends_on 'python3' => :build

  no_source_build
end
