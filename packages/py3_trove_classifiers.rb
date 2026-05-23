require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.5.22.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'babbb9dc37ea8c3003beda854328b2472aca473f7a3ad9a32842a7e2a15f0b8f',
     armv7l: 'babbb9dc37ea8c3003beda854328b2472aca473f7a3ad9a32842a7e2a15f0b8f',
       i686: '7364cdc85095bb7ea028b4799dae891cd138ad4e1a9dbd373baf36c41e33c456',
     x86_64: '3f1ff7db2d3277cf10a15be202dabd6d5ba3e6c99876e56806e2b06937f7864f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
