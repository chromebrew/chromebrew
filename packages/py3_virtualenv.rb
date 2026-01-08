require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.36.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2e576daf04a822e4ff4004189f55ac26fbaed649f22c7b001dbc1c75ac4a668',
     armv7l: 'd2e576daf04a822e4ff4004189f55ac26fbaed649f22c7b001dbc1c75ac4a668',
       i686: 'e870b20f8823234f6fb9bedae18c9f120e418dcf1d09d9e1de7a5f98db3c0d7c',
     x86_64: '3d2c4289788350c62a08ce878a1964e8944210a9b060d9fb8aebbc39ab043b1b'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
