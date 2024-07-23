require 'buildsystems/pip'

class Py3_hatch_fancy_pypi_readme < Pip
  description 'MIT-licensed metadata plugin for Hatch'
  homepage 'https://github.com/hynek/hatch-fancy-pypi-readme'
  @_ver = '23.1.0'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_hatch_vcs' => :build
  depends_on 'python3' => :build

  no_compile_needed
end
