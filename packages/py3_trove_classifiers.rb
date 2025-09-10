require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.9.9.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1aa47f15ee6dfebfcb4d9a640feab3f579a96e89e08b1162ff2b4bee5203a545',
     armv7l: '1aa47f15ee6dfebfcb4d9a640feab3f579a96e89e08b1162ff2b4bee5203a545',
       i686: '90f8ad842add1c97d6910b3ecc1d679111997d92e67e85314373c044ea3dc3fb',
     x86_64: '6b12dc0ae91bffe2c6c1726c3ba214f77da2fd35c59a26c83b1d6136abda1ffc'
  })

  depends_on 'python3' => :build

  no_source_build
end
