require 'buildsystems/pip'

class Csvkit < Pip
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'https://csvkit.readthedocs.io/en/latest/'
  version '2.1.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '237442c5f24223eeaee2c8d93d706b47880ab9506038cef0c40158fc59b5b486',
     armv7l: '237442c5f24223eeaee2c8d93d706b47880ab9506038cef0c40158fc59b5b486',
       i686: '294dc0cc7ee96c87d137e2afd8219d3a10c6d9cc667c36adfe8ce67a7ef70ce8',
     x86_64: '1f2311ce413c14a19152d26b5a66baaa3ef3c8f3526a1b81337709f68c7b1c78'
  })

  depends_on 'py3_agate'
  depends_on 'py3_agate_dbf'
  depends_on 'py3_agate_excel'
  depends_on 'py3_agate_sql'
  depends_on 'python3'

  no_source_build
end
