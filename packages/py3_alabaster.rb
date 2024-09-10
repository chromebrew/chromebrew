require 'buildsystems/pip'

class Py3_alabaster < Pip
  description 'Alabaster is a configurable sidebar-enabled Sphinx theme.'
  homepage 'https://alabaster.readthedocs.io/'
  version '1.0.0-py3.12'
  license 'BSD' # License is BSD-style, might be BSD-3?
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfc6e0bcb69911fee7cf70b8cc6d30d4b911314a159528ce90ade4caf2f4fa04',
     armv7l: 'dfc6e0bcb69911fee7cf70b8cc6d30d4b911314a159528ce90ade4caf2f4fa04',
       i686: '17490d26dc5dbdfce11245de710bbebc08dd14b1c738e1f04a92b6373d37e076',
     x86_64: '3528849402fbd7076949b9018e78f6488b288dfdba7966913444444a3cfd52db'
  })

  depends_on 'python3' => :build

  no_source_build
end
