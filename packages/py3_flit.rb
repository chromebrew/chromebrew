require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version "4.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25869ce0475a60369b0a79fa8b5cdb5a0b887f959b5336262f1fc8334ea2199e',
     armv7l: '25869ce0475a60369b0a79fa8b5cdb5a0b887f959b5336262f1fc8334ea2199e',
       i686: 'd0dff16904f55ac6c35f7c2e80471a8a638b4d486554d2efceedd4e703b7c27f',
     x86_64: '1dc4bc492a97c49f4446a7b7a9e63a6d0c29d2d53cb74169d21130eac915cca2'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'
  depends_on 'python3' => :logical

  no_source_build
end
