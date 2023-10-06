require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '23.2'
  version "#{@_ver}-py3.12"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'
  no_compile_needed
  depends_on 'py3_pyparsing'
end
