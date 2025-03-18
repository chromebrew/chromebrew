require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.36.2-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4609b1c93c1967e51aaf2b2bddf40103dced104f382691b4046ca4773e5e94ef',
     armv7l: '4609b1c93c1967e51aaf2b2bddf40103dced104f382691b4046ca4773e5e94ef',
       i686: '70569bc40cb4ae8b334cbe3f8a2b1e3930aa679797f551b53f1998e63112048a',
     x86_64: '04ef7db5779911cf767df0218d66e40b0dfdef40bf5d2168dee94a4ada0fd439'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
