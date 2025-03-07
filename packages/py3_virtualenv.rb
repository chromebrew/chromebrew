require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.29.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3976d74ccca69df5b2de2eb904d12791cfa15b04ef43e0b34d25335f8e83302b',
     armv7l: '3976d74ccca69df5b2de2eb904d12791cfa15b04ef43e0b34d25335f8e83302b',
       i686: '60980a32f4a3d8c67d8a27f8456eb27b7c10f31158b59e72af6738703da1ebcb',
     x86_64: '16c1483a639dd54609e9583f78285a640a12b3c8cc95f2b7b226124db5218315'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
