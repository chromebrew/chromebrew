require 'buildsystems/pip'

class Py3_trove_classifiers < Pip
  description 'Canonical source for classifiers on PyPI.'
  homepage 'https://github.com/pypa/trove-classifiers'
  version "2026.6.1.19-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3dd714604d4b6ee03af6b3cf81fb6fa43e83879de2348e121a975ac544526adf',
     armv7l: '3dd714604d4b6ee03af6b3cf81fb6fa43e83879de2348e121a975ac544526adf',
       i686: '572e499991207ede83fe194d86002280f6e04e874949d5f73a163b7c5aee6cb8',
     x86_64: 'eec87113bc4d00e9f5821e9fe745ab4df0ebcff74da01af5b44d3753e5c6cd32'
  })

  depends_on 'python3' => :logical

  no_source_build
end
