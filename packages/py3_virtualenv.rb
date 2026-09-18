require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.11-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a966a5dd9f8ca0c538834cf2feae9e36194977ef23731d377048cbfe2d055e0c',
     armv7l: 'a966a5dd9f8ca0c538834cf2feae9e36194977ef23731d377048cbfe2d055e0c',
       i686: 'e6fde4e0acea95bd94a9b18a583086658f98c4ad5e1e65eab1a59008b7a4f0e6',
     x86_64: '484f648ad13a3338ba7fcade49fc1706e2f54368b6a045c4db0168766819d74a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
