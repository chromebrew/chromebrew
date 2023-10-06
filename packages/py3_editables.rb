require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  @_ver = '0.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' => :build

  no_compile_needed
end
