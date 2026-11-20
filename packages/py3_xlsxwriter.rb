require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.3.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8afa252c1d63dfcbc66838b6d078ce57a27c0da85e645b7ac74738056bf02755',
     armv7l: '8afa252c1d63dfcbc66838b6d078ce57a27c0da85e645b7ac74738056bf02755',
       i686: '8d2210515952a42b9d6c05390b10d36c3df569b1dc20fd8e88bd5336483e7d29',
     x86_64: 'd5e8c49cbb01d367f26b68419e6418e8b31402293ba593fffa1043b29f9b38ec'
  })

  depends_on 'python3' => :logical

  no_source_build
end
