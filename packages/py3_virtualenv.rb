require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.28.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a619d22cae8d427ab7a152c7aa1914165a57cf9dd49b5d626df15400ea7a66a7',
     armv7l: 'a619d22cae8d427ab7a152c7aa1914165a57cf9dd49b5d626df15400ea7a66a7',
       i686: 'bf6a29299168a5fc66297f082b9e85e21d7137ee499d95f2be36add9d43839d8',
     x86_64: 'e5649919cefbe5f5e301b3c23dc0000c9a0077c285026504f1be4ad92f940b6b'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
