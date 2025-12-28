require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20251227-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c2e4e6306caf634cf7d82a3ab60b468b8a273448e425884d23344d0a7bb7302',
     armv7l: '1c2e4e6306caf634cf7d82a3ab60b468b8a273448e425884d23344d0a7bb7302',
       i686: '6715c2714001aca4409487c6a5cb0fec2c2cc24365ffbbbf3262141b43239cce',
     x86_64: '73de578b222d286420539cfc274d52b9340960883a3538637427f770164b1bcb'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
