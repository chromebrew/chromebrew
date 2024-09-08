require 'buildsystems/python'

class Py3_pypdf < Python
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version '4.3.1-py3.12'
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'https://github.com/py-pdf/pypdf.git'
  version '4.3.1-py3.12'
  binary_compression 'tar.zst'

  depends_on 'python3'
end
