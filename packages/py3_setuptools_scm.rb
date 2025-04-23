require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version "8.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8860d3c6ab0426b112cd094309599e7ef0bfff64840f448b74a32855f1ff7b64',
     armv7l: '8860d3c6ab0426b112cd094309599e7ef0bfff64840f448b74a32855f1ff7b64',
       i686: 'd2766b3c69e9735a323967e0870565cfabf90857f43523a13c19cbe66e12bde4',
     x86_64: '1d3af0188714f96c241b83d6784b5b8ffa63d1361abb9bbf04baf7e0dac39942'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
