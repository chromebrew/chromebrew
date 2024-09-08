require 'buildsystems/pip'

class Py3_dbfread < Pip
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  version '2.0.7-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'python3' => :build
end
