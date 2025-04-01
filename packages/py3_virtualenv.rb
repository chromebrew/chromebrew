require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.30.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3976d74ccca69df5b2de2eb904d12791cfa15b04ef43e0b34d25335f8e83302b',
     armv7l: '3976d74ccca69df5b2de2eb904d12791cfa15b04ef43e0b34d25335f8e83302b',
       i686: '77f786f817a8589fd51240c9bd18f57a8279280510881ecbb934bac82980ca08',
     x86_64: '16c1483a639dd54609e9583f78285a640a12b3c8cc95f2b7b226124db5218315'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
