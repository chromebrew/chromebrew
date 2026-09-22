require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.9.21.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eae21ca055ccc589cdc426ef458efc6acd939acc404c4544478b6fdca07b8f81',
     armv7l: 'eae21ca055ccc589cdc426ef458efc6acd939acc404c4544478b6fdca07b8f81',
       i686: '16982c68d6b86f997dca5014f9cbdceaa82b0b44a22fdca7c95ba79dbbada5d3',
     x86_64: '959b3ed539decdb002086e5b5d3ff3942038bfa2dd6356071e2ab4721b536c95'
  })

  depends_on 'python3' => :logical

  no_source_build
end
