require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version "3.12.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f10ef06fce895d3e08657d6b69bab78035aa784223110cd0a472e274d2b2f4c4',
     armv7l: 'f10ef06fce895d3e08657d6b69bab78035aa784223110cd0a472e274d2b2f4c4',
       i686: '59bb3ee65ae466475a3013f601a7beb6dcdc1276de2c02f9b968c03c04ae5472',
     x86_64: '44c86a3742d7ccae7b01b3dfa2cc3054f04a560e323c17bb8a8d166e166196c8'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  no_source_build
end
