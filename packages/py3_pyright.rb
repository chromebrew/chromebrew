require 'buildsystems/python'

class Py3_pyright < Python
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version '1.1.379-py3.12'
  license 'MIT'
  compatibility 'all'
  min_glibc '2.28'
  source_url 'https://github.com/RobertCraigie/pyright-python.git'
  version '1.1.379-py3.12'

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_compile_needed
end
