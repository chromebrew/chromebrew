require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version '24.1-py3.12'
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
