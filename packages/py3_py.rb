require 'buildsystems/pip'

class Py3_py < Pip
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.11.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
