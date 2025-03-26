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
       i686: 'fa7141967fd63b5b2eba5a2f4596a6eb4bef3963409d427bb78d3b7fbc97f5b1',
     x86_64: '8729b4bba8fc770d6cf796c2cdef5e13783359f7005c6b4ed1975e2416bd538c'
  })

  depends_on 'python3'

  no_source_build
end
