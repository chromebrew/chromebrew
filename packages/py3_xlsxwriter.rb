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
    aarch64: 'c92ac59be50918bdf6ef7c8cd4963f97e5cb4cd482658153f55e42442af7af62',
     armv7l: 'c92ac59be50918bdf6ef7c8cd4963f97e5cb4cd482658153f55e42442af7af62',
       i686: 'd9073315d8455d014956d9bdef40a59a278cfa860634c174062b8a64456d2181',
     x86_64: '6046c0ccad36d1aa96f02dbd4afaf6e0c2ed02e1666d17c6016f321e7a946a9d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
