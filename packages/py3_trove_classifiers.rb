require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.5.1.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae69b318a919b7bfd0c004831d6fce67e86b897dfbbd38dd56181a08824f3fc3',
     armv7l: 'ae69b318a919b7bfd0c004831d6fce67e86b897dfbbd38dd56181a08824f3fc3',
       i686: '8670d7637159fb25bd38bf3702bc577215e85c988ea0f4cf67b4a640c6be105a',
     x86_64: 'ee0a8754739788693b4f0650ec16cfbb8c0ce7d830612086a05e1739736c16b1'
  })

  depends_on 'python3' => :build

  no_source_build
end
