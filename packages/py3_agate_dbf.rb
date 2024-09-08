require 'buildsystems/pip'

class Py3_agate_dbf < Pip
  description 'Agate-dbf adds read support for DBF files to agate.'
  homepage 'https://agate-dbf.readthedocs.org/'
  version '0.2.3-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_dbfread'
  depends_on 'py3_agate'
  depends_on 'python3' => :build
end
