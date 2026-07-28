require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "7.0.0-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ddcf2b70549a23cc0a1b9b143e82a97bdf25ac7e9a2878d1effeeff8ec70e96',
     armv7l: '0ddcf2b70549a23cc0a1b9b143e82a97bdf25ac7e9a2878d1effeeff8ec70e96',
       i686: '774e1dcda455abc56741672c86a76a8ec9313aa4f275689e48cbc5c74f950499',
     x86_64: '310d067ac043c866406fc113a09c8a5d740ef9a87a922745dc6095db5ca2a23d'
  })

  depends_on 'py3_certifi'
  depends_on 'py3_id'
  depends_on 'py3_keyring'
  depends_on 'py3_readme_renderer'
  depends_on 'py3_requests'
  depends_on 'py3_requests_toolbelt'
  depends_on 'py3_rfc3986'
  depends_on 'py3_rich'
  depends_on 'py3_setuptools'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
