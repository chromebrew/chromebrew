require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.38.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7160a9ab3edf40a50f1fa67dbfe364cc1dd0f6d48621a6b37cd746fed5d6cf46',
     armv7l: '7160a9ab3edf40a50f1fa67dbfe364cc1dd0f6d48621a6b37cd746fed5d6cf46',
       i686: 'f1c7f501d7d6aaf02e2ef2d4adafa5770da236006c22e07dcad262c411ce9e19',
     x86_64: '3c2f380b1c30a04c89e9ca986d588bf69f17865fcce0762e52823d0549310814'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
