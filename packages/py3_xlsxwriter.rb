require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.3.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e8af01149fe5bd8e5bb62180abd964213576164531078f6528f29237b4a7c23',
     armv7l: '5e8af01149fe5bd8e5bb62180abd964213576164531078f6528f29237b4a7c23',
       i686: '19875cca96468410eeb772d105483286f2405ad2824a55c5cf6101f2700c20a6',
     x86_64: '04fd07e812dd6745e6ac5b393313af0f3748d156591320376304ba5f9be10c1f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
