require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.3.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd16b5c27dd5a2007db886f28c6a1164d64fdeb3106ccd353a3954811fb30bbf6',
     armv7l: 'd16b5c27dd5a2007db886f28c6a1164d64fdeb3106ccd353a3954811fb30bbf6',
       i686: '9de2bc97248ab76127cb1d09de54902c26ac1f74add6546e42565de81a4ae33f',
     x86_64: '53ae730f8f7272a0881a83a2dd747301ddee40b5b102da808648844fa8a085c5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
