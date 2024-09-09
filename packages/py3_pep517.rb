require 'buildsystems/pip'

class Py3_pep517 < Pip
  description 'Python PEP517 is an API to call PEP 517 hooks for building Python packages '
  homepage 'https://pep517.readthedocs.io/'
  version '0.13.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
