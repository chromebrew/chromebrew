require 'buildsystems/pip'

class Py3_yamllint < Pip
  description 'YAMLlint is a linter for YAML files.'
  homepage 'https://github.com/adrienverge/yamllint/'
  version "1.36.1-#{CREW_PY_VER}"
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4609b1c93c1967e51aaf2b2bddf40103dced104f382691b4046ca4773e5e94ef',
     armv7l: '4609b1c93c1967e51aaf2b2bddf40103dced104f382691b4046ca4773e5e94ef',
       i686: 'eb13eeaf634990ee429fe4bcd0aa6c7cd82bed2134c2ffeb65cb84e8618eea9a',
     x86_64: '8d0901acec5eb8ca47b924d8d8f97bdb61adf12ad796293c3abc306380d3bfb1'
  })

  depends_on 'py3_pathspec'
  depends_on 'py3_pyyaml'
  depends_on 'python3' => :build

  no_source_build
end
