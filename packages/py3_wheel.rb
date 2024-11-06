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
    aarch64: '6bc46689a5fc62323501cae3d69971a2209f65975d7aa8d34b0f3670a0406c30',
     armv7l: '6bc46689a5fc62323501cae3d69971a2209f65975d7aa8d34b0f3670a0406c30',
       i686: '8fbfd17fcba34451310f156338b71eb6a0361ded802295817c646fdd83f610d9',
     x86_64: '83d46929fd6bb77c0e2a7e06f00c31ecb12187c4f55e8eae45cc325475bc4d53'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
