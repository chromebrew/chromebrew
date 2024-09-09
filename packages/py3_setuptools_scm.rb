require 'buildsystems/pip'

class Py3_setuptools_scm < Pip
  description 'Setuptools-scm is the blessed package to manage your versions by scm tags.'
  homepage 'https://github.com/pypa/setuptools_scm'
  version '8.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_packaging'
  depends_on 'py3_tomli'
end
