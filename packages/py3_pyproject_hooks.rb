require 'buildsystems/python'

class Py3_pyproject_hooks < Python
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version '1.1.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/pyproject-hooks.git'
  version '1.1.0-py3.12'
  binary_compression 'tar.zst'


  depends_on 'python3'
  depends_on 'py3_tomli'
end
