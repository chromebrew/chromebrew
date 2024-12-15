require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2024.12.14-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61bc904434759198ddfd30a6cec6a340e87daf15f186ab9556eb083bb43dbfee',
     armv7l: '61bc904434759198ddfd30a6cec6a340e87daf15f186ab9556eb083bb43dbfee',
       i686: 'eb86cc67fbecb05b079de34731d7e4cac0aed998e7eee3bfc6c747a71ac377f5',
     x86_64: '14ec36af51a0c546fd5f9e0e6a61a242b7d420466569a6f4eba25e8bb9844c8f'
  })

  depends_on 'python3' # L

  no_source_build
end
