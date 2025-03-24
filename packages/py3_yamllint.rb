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
     x86_64: '04ef7db5779911cf767df0218d66e40b0dfdef40bf5d2168dee94a4ada0fd439'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
