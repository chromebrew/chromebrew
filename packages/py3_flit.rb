require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version "3.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef8a42ac074cc2be6eacaa9009047fa0328dbee4e654b926033f206b8a649975',
     armv7l: 'ef8a42ac074cc2be6eacaa9009047fa0328dbee4e654b926033f206b8a649975',
       i686: '0cb61118e416d7ad3b3f0eeb1812d0e827d5909c5afafd5858b455e4810edb05',
     x86_64: '88c43c6e353d0998ad564eff8e2c1c0670a3afff7d185f8a00dc9294766c7c0f'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  no_source_build
end
