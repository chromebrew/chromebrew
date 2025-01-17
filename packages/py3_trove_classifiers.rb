require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.1.15.22-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '456f0f403fcfee77965c5b510f25c1e84cc2a005c2cbc6ddc68c39ce77c15466',
     armv7l: '456f0f403fcfee77965c5b510f25c1e84cc2a005c2cbc6ddc68c39ce77c15466',
       i686: '0de173d6d0d30664c13bbc462b587332b1f797ed00c59d11e3956fb9b0173ccb',
     x86_64: '1eed9dbab90a5493100bcd3a911f69f55de340965a87608b9bc2adacae6902b1'
  })

  depends_on 'python3' => :build

  no_source_build
end
