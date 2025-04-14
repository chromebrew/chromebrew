require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2025.4.11.15-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '168d3d54dd130bb0641d506443ab73fd0b1bea75f79ad259966b9a0cb8c0fdfe',
     armv7l: '168d3d54dd130bb0641d506443ab73fd0b1bea75f79ad259966b9a0cb8c0fdfe',
       i686: '697befeb909ac80e8af7face99ed5a203428f6a393547e3926bb3242c72f5c3e',
     x86_64: '29f950c2a084d46d8394031504a06aae18f79e4898fd84017d68cc0ecb0f78d1'
  })

  depends_on 'python3' => :build

  no_source_build
end
