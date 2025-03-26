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
    aarch64: '2c145233463601c0c38af5847850d9d0d190ccafd7422f68cf2f76ded5f2d7ed',
     armv7l: '2c145233463601c0c38af5847850d9d0d190ccafd7422f68cf2f76ded5f2d7ed',
       i686: '6dadddc8188084eff72f702dc78972e28f6fd7849f2980e076ef0f63b373b11f',
     x86_64: 'dfe46d648fa315944c7ee2b4b5485feec2c9cc44b0d57c9420acc25a92ec1dfd'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  no_source_build
end
