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
    aarch64: '8ba40243ce742d51c70124b8d74e9321e77f4cc6896bf6795cf0b559f1894cda',
     armv7l: '8ba40243ce742d51c70124b8d74e9321e77f4cc6896bf6795cf0b559f1894cda',
       i686: '6dadddc8188084eff72f702dc78972e28f6fd7849f2980e076ef0f63b373b11f',
     x86_64: '544eca0d4abb07d44c5fdff0d381d16b1c994c725683d9731c7ae928adeb5de2'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  no_source_build
end
