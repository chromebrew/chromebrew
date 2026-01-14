require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.36.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ef16751d05c3c02e0a846f7d751ba41f877795fdd3857dfdbc5f45eff66e6ca',
     armv7l: '9ef16751d05c3c02e0a846f7d751ba41f877795fdd3857dfdbc5f45eff66e6ca',
       i686: 'e43cbf349c576886dc3ad8a2bc31449d84718c2b87fe70148935d21cd67e58c8',
     x86_64: 'ccc069db103aaa97d8328bb9722fc1629374953dd40c3c9e89344385f12cad8f'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
