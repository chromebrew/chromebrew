require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2024.8.30-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61bc904434759198ddfd30a6cec6a340e87daf15f186ab9556eb083bb43dbfee',
     armv7l: '61bc904434759198ddfd30a6cec6a340e87daf15f186ab9556eb083bb43dbfee',
       i686: '8e2d0171481fdafd171d14f971607331bb0d948e99515fc43b3b6f80147661af',
     x86_64: '14ec36af51a0c546fd5f9e0e6a61a242b7d420466569a6f4eba25e8bb9844c8f'
  })

  depends_on 'python3' # L

  no_source_build
end
