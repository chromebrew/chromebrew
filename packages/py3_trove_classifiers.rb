require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.3.13.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79bf8481240b4a7c75a27ce00904b4bd7635320ab301b0b82b54c2e4d13ceea1',
     armv7l: '79bf8481240b4a7c75a27ce00904b4bd7635320ab301b0b82b54c2e4d13ceea1',
       i686: '915e63c6c6311e4eb4d13764d63ead8dff3c6012510c063952d36feee601ce94',
     x86_64: '3c15615482a1957497df8601e9d80b17a610e7053f58406816d0d27038b60301'
  })

  depends_on 'python3' => :build

  no_source_build
end
