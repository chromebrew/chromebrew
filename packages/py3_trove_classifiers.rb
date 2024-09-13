require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version '2024.9.12-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3727cc5d7c47efacee815f9d27bb2a7893df9a7dc639de3decb31b9614fb5f1',
     armv7l: 'f3727cc5d7c47efacee815f9d27bb2a7893df9a7dc639de3decb31b9614fb5f1',
       i686: 'f12d2f5664c9efc4d47d0c6ec97e097ce058b8f9275ee7f78a1e6a8111d79937',
     x86_64: '05090fa04d9816b5b76b1b320c3ca1c0515a3f0f60517fc67fc7b1c871ff556d'
  })

  depends_on 'python3' => :build

  no_source_build
end
