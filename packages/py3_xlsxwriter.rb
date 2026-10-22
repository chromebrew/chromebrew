require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.3.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4cd70d9369e94d009990a3e269faf81f3bf06978a0ccda35bd6cc5a04b66d40',
     armv7l: 'b4cd70d9369e94d009990a3e269faf81f3bf06978a0ccda35bd6cc5a04b66d40',
       i686: 'd97d461456cea753d09431da8669890e967f114b1603091ad04cbcaf0eac930d',
     x86_64: 'a77f7ba9dfe5d0a4a94ef11da37c21c8516ff139ef852e365f462b4bcd01ecd0'
  })

  depends_on 'python3' => :logical

  no_source_build
end
