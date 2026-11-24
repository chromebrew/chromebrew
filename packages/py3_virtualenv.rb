require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a036d79471710e1f1c2086bd247b69c5eeb8dde0fccbc8879c332e9ae5bf2e6',
     armv7l: '6a036d79471710e1f1c2086bd247b69c5eeb8dde0fccbc8879c332e9ae5bf2e6',
       i686: 'f4f1f225668ac21f2ec6c9b433196da78547e8206c7d615244d2477abfc43347',
     x86_64: 'bbe5c689e9c9d8ef94815001715e9ade8e670d2e33ec3aeeb391b3ab672c8850'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
