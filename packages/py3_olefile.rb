require 'buildsystems/pip'

class Py3_olefile < Pip
  description 'Olefile is a Python package to parse, read and write Microsoft OLE2 files.'
  homepage 'https://www.decalage.info/python/olefileio/'
  version '0.47-py3.12'
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'


  depends_on 'python3' => :build
end
