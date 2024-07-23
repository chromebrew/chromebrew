require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  @_ver = '1.0.3'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_compile_needed
end
