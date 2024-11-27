require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '154de9a1809a4a36a69ce076098ec4b8d7ff114d18730994e9a1f789167fa20e',
     armv7l: '154de9a1809a4a36a69ce076098ec4b8d7ff114d18730994e9a1f789167fa20e',
       i686: 'e620187f666f175db28b3b734cb89194398cdcda2229b89f5048eed8b2fc0973',
     x86_64: '1af9e4112186ab6a2f0447056b6da69783841704b2ab2fa395bbb91b3d9af587'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
