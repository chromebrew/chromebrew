require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version '3.9.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88d5b7182b3ef924001a63934becdff636d034d7c5c7bce1aa8f539ef82b8814',
     armv7l: '88d5b7182b3ef924001a63934becdff636d034d7c5c7bce1aa8f539ef82b8814',
       i686: '290042725268a302a63249d94407413e9dab01abf9180298187ac9d95af4cbf8',
     x86_64: '56573a84558626d18e4c3e42a8fd5eb9c5097f557bb0de7bafa8b575caefa8bc'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  no_source_build
end
