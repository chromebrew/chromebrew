require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version '1.1.379-py3.12'
  license 'MIT'
  compatibility 'all'
  min_glibc '2.28'
  source_url 'SKIP'

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_compile_needed
end
