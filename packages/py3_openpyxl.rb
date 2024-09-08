require 'buildsystems/pip'

class Py3_openpyxl < Pip
  description 'Openpyxl is a Python library to read/write Excel 2010 xlsx/xlsm files.'
  homepage 'https://openpyxl.readthedocs.io/'
  version '3.1.5-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_et_xmlfile'
  depends_on 'python3' => :build
end
