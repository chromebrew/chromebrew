require 'buildsystems/pip'

class Py3_python_magic < Pip
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  version '0.4.27-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'filecmd'
  depends_on 'python3' => :build

  no_compile_needed
end
