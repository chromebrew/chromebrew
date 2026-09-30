require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67e6e56a4b1bf0419c52cb4199a0d42433ed912e9d1602096a0bc38e9a720f39',
     armv7l: '67e6e56a4b1bf0419c52cb4199a0d42433ed912e9d1602096a0bc38e9a720f39',
       i686: '1aca30aa008af7217ed9519b34fb734fa460a3a3f25a9fb962f7f3e72e505eab',
     x86_64: '707ef9c4c5564ef633ebf93def04bdbf132b17aabbf185e1b8eac67c4d33a574'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
