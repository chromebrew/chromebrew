require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "3.12.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e6833587fd125f763a3727bfb9e287ce96eeade90508a0f84c31c6950e5bf9ff',
     armv7l: 'e6833587fd125f763a3727bfb9e287ce96eeade90508a0f84c31c6950e5bf9ff',
       i686: 'd01e84c49591bd1a44822db1c7970c2cbec3c2d42a786c9d15cc0ddc39d176f0',
     x86_64: '30f90e01b31826d9cfd160e97badcfaae2242862e818046780578615e03194b6'
  })

  depends_on 'python3'

  no_source_build
end
