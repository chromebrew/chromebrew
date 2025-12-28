require 'buildsystems/pip'

class Csvkit < Pip
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'https://csvkit.readthedocs.io/en/latest/'
  version '2.2.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7fcf87a074099ec53ff818fa94de501cf792a931a2ba7c3b3f5c8052ebf127fc',
     armv7l: '7fcf87a074099ec53ff818fa94de501cf792a931a2ba7c3b3f5c8052ebf127fc',
       i686: '8758ffb68571a89e9550e1e0a3e6095d8d1e151eaf121883a358825d51cbd218',
     x86_64: '61e5538a80df2213477bde09da18b8d4c2b5375fedd866e1eebbb1acdfbd0dca'
  })

  depends_on 'py3_agate'
  depends_on 'py3_agate_dbf'
  depends_on 'py3_agate_excel'
  depends_on 'py3_agate_sql'
  depends_on 'python3'

  no_source_build
end
