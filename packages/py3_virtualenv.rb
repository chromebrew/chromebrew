require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '952a0f31449aba1147297e97f40b028e87df182b07f1d5e8ead853144f046aa5',
     armv7l: '952a0f31449aba1147297e97f40b028e87df182b07f1d5e8ead853144f046aa5',
       i686: 'fe3310709cac71c832eb908676f5039dd55bcbb87aa2d02a5fc42b7b98ffef78',
     x86_64: 'e8a3e9a6eea17479c57f4ddd1a56116e33605a30ee8c8fcc90eb87b8746fafff'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
