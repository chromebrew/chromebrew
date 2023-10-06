require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  @_ver = '3.24.4'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_compile_needed
end
