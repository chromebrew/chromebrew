require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  @_ver = '1.26.3'
  version "#{@_ver}-py3.12"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_compile_needed
end
