require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.8.6.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f5044e697766f10d6a468141a5e5b31c9353bc953585564e386363a9cc7554dd',
     armv7l: 'f5044e697766f10d6a468141a5e5b31c9353bc953585564e386363a9cc7554dd',
       i686: '6d6db7ad229617efa8b941fa89552512043b3c063df68ca8696631fff9c775cd',
     x86_64: 'be893d7d6e5e4b4896e461ab319394c1215f6bc8ce220f8c230b1f1dcc2af575'
  })

  depends_on 'python3' => :build

  no_source_build
end
