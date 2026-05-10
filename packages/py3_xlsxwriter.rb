require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.9-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f8e5abfde51d58189230bba157a737f157ed9bf574b7e2192178a5ec5854496',
     armv7l: '2f8e5abfde51d58189230bba157a737f157ed9bf574b7e2192178a5ec5854496',
       i686: '9605eb627858028fd54ef5d16f620ec9fe21503c1dfc955b08f48eb529610bb0',
     x86_64: '341ce1543b5363c902b2de5824fce811fdd813a4b45f1886c18b69527ac4f0e6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
