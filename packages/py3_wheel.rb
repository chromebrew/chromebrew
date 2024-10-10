require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.44.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e213456d7a2aea62c2c79adc7796093b01564c2b4bc59d1f7bb58b07151c66a1',
     armv7l: 'e213456d7a2aea62c2c79adc7796093b01564c2b4bc59d1f7bb58b07151c66a1',
       i686: '9fbab3e617469fec6e0b6d5028f6af684e08e2bf356f3b7f9d53f78392bce124',
     x86_64: '55490b8bf4da8aad5413aec0f0df6ae6d5edefe02038e3028b264d6ddbf697d5'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
