require 'buildsystems/pip'

class Csvkit < Pip
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'https://csvkit.readthedocs.io/en/latest/'
  version '2.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  depends_on 'py3_agate'
  depends_on 'py3_agate_dbf'
  depends_on 'py3_agate_excel'
  depends_on 'py3_agate_sql'
  depends_on 'python3'

  no_source_build
end
