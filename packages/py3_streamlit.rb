require 'buildsystems/pip'

class Py3_streamlit < Pip
  description 'A faster way to build and share data apps'
  homepage 'https://streamlit.io/'
  version "1.62.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4ad1bf62a63e63e8c5af060476bbb50817121e9376122620621a35674cf5d34c',
     armv7l: '4ad1bf62a63e63e8c5af060476bbb50817121e9376122620621a35674cf5d34c',
       i686: '6048be2e366dff755a11758d1c919ed285ef62be0888aab819675dfff945d413',
     x86_64: '152020044ed0b62949643187cb412d6fc19e32b0512d3a2919750691a225913b'
  })

  depends_on 'python3' => :logical

  no_source_build
end
