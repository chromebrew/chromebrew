require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version '3.9.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3'
end
