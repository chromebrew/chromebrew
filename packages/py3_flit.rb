require 'buildsystems/pip'

class Py3_flit < Pip
  description 'Flit provides simplified packaging of Python modules.'
  homepage 'https://flit.pypa.io/'
  version "3.11.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02fd1c35ef6cc5087170eefb1491e99a5895f2477dab8d31e7c25f24b84c785d',
     armv7l: '02fd1c35ef6cc5087170eefb1491e99a5895f2477dab8d31e7c25f24b84c785d',
       i686: 'ccb6c052aebe3039357ac871576c0ffe2bc3226b5d0f24bd18b24c44b386a070',
     x86_64: 'dfe46d648fa315944c7ee2b4b5485feec2c9cc44b0d57c9420acc25a92ec1dfd'
  })

  depends_on 'py3_docutils'
  depends_on 'py3_flit_core'
  depends_on 'py3_tomli'
  depends_on 'py3_tomli_w'

  no_source_build
end
