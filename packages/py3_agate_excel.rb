require 'buildsystems/pip'

class Py3_agate_excel < Pip
  description 'Agate-excel read support for Excel files (xls and xlsx) to agate.'
  homepage 'https://agate-excel.readthedocs.io/'
  version "0.4.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2511c542b6d12deeb8b7f575557c66eac8c5c6ae0d34c8c23f678a6b86334af3',
     armv7l: '2511c542b6d12deeb8b7f575557c66eac8c5c6ae0d34c8c23f678a6b86334af3',
       i686: '8fb9b2b785572b239c50dac61c015e162c3eb90d8eaf212f1c055ee4490d936b',
     x86_64: '575d375f9aedc51e32f4ebef284a2843c136516af0619dd83c665b9e1cb9bc7b'
  })

  depends_on 'py3_agate'
  depends_on 'py3_olefile'
  depends_on 'py3_openpyxl'
  depends_on 'py3_xlrd'
  depends_on 'python3' => :logical

  no_source_build
end
