require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.46.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfb42e6b1046c096f2127a6b42282f7264e6e4952ca28c13ffdefb53c0ac3cbf',
     armv7l: 'bfb42e6b1046c096f2127a6b42282f7264e6e4952ca28c13ffdefb53c0ac3cbf',
       i686: 'd1967611d5d2792427062917fe6e7e55df75ffcd94d131d75ccdaa3974ca2ffd',
     x86_64: 'c57336dabe9f221814d382bb90b53ce51d713c21bfd55abdf23a5477ae7f17f9'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
