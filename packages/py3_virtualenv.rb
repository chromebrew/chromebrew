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
    aarch64: 'ca7c255407a4be7003764aa00468115bf53692f2859d79a7b4d2850ea7219b92',
     armv7l: 'ca7c255407a4be7003764aa00468115bf53692f2859d79a7b4d2850ea7219b92',
       i686: '865044d79185ad67cb3c58c568f4826686f2647f7f2be8e86b70a4c52540f1c8',
     x86_64: '8d8a064510e91a3d57b050362d3059a2e7ade6fa7fb215619712da5e0255d928'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
