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
    aarch64: 'cdf34d1a2f1f3885e56bb921ba4d3dd67a88c68c6b9e2b7165251a88dbbd85de',
     armv7l: 'cdf34d1a2f1f3885e56bb921ba4d3dd67a88c68c6b9e2b7165251a88dbbd85de',
       i686: '72d64671cd9fe392875f5ac6b89ffc06f80c669665b9d19d652045eb0312f511',
     x86_64: 'f4793bc63cc094c2f9e11024085b7a68afe76939242d0005c326be22f96722f2'
  })

  depends_on 'python3' => :build

  no_source_build
end
