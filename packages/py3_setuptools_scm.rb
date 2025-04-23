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
    aarch64: '8ae48ff6fbc2ab5a643c5e9df82ab7aeea61c46db43b95a2732099d44b130e3e',
     armv7l: '8ae48ff6fbc2ab5a643c5e9df82ab7aeea61c46db43b95a2732099d44b130e3e',
       i686: 'd2766b3c69e9735a323967e0870565cfabf90857f43523a13c19cbe66e12bde4',
     x86_64: '2ee715cbd66fe143d83bcd0ea34608324744ba3f1867e0600954bfa9b815d4db'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'

  no_source_build
end
