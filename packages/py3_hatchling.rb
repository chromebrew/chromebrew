require 'buildsystems/pip'

class Py3_hatchling < Pip
  description 'The extensible, standards compliant build backend used by Hatch.'
  homepage 'https://hatch.pypa.io/latest'
  version "1.32.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4528b10653be339f5ec4eecf5cf271262595ea2702afdd5bd54a099098a1aba',
     armv7l: 'c4528b10653be339f5ec4eecf5cf271262595ea2702afdd5bd54a099098a1aba',
       i686: '1251f898afa90380b39444bf916fa17b6521a1704357f2afaf7abbb50a92901b',
     x86_64: '347a800820d5c34dcb5dd18e48efb66ba2ebaf2eb0fbfe9637684a2785530221'
  })

  depends_on 'py3_editables'
  depends_on 'py3_pathspec'
  depends_on 'py3_pluggy'
  depends_on 'py3_trove_classifiers'
  depends_on 'python3' => :logical

  no_source_build
end
