require 'buildsystems/pip'

class Py3_arrow < Pip
  description 'Arrow is a Python library that offers a sensible and human-friendly approach to creating, manipulating, formatting and converting dates, times and timestamps.'
  homepage 'https://arrow.readthedocs.io/'
  version "1.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a9d528698e9013deea819ed02667c2b71d5589d9fd9f7953226389567b42595',
     armv7l: '0a9d528698e9013deea819ed02667c2b71d5589d9fd9f7953226389567b42595',
     x86_64: '2ed09311114d67fa61cd65aedcbe39701c1e5fc2c70450744d3fe383350ac76a'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :build

  no_source_build
end
