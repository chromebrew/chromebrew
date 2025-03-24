require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.37.0-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '522cec5b16b537211ded83ca3bdf3b68c42f3e2f5b32d7a13c9d19709d349b61',
     armv7l: '522cec5b16b537211ded83ca3bdf3b68c42f3e2f5b32d7a13c9d19709d349b61',
       i686: '3bdaea1277a60d427674932cb92dc0946484817547f67fa80d62ba3054a05a55',
     x86_64: '88ca60b395edcbc462a029e345d596fc4ff64919376210cc9ed846fabf2d97e1'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
