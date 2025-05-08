require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.31.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db31eb4e9316a057d6721bc99211c20a1c9d85f0814a288fbb94eb5ec0df6837',
     armv7l: 'db31eb4e9316a057d6721bc99211c20a1c9d85f0814a288fbb94eb5ec0df6837',
       i686: '3576079a20eb54bc1e0c4584b2103890d3a8690c6581f2b82d1c59613db1ab1f',
     x86_64: '31fda791392772b31948b45bf0f185114544ef4cbc97d0fd96d63c3ab37ef6d8'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
