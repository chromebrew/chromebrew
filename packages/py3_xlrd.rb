require 'buildsystems/python'

class Py3_xlrd < Python
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  version '2.0.1-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/python-excel/xlrd.git'
  version '2.0.1-py3.12'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
