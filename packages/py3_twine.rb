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
    aarch64: '6a1bb7c9ee5827295aaf730a32383dd79b38def508275d511c86041732f25d0b',
     armv7l: '6a1bb7c9ee5827295aaf730a32383dd79b38def508275d511c86041732f25d0b',
       i686: '10c61ea3242876eca2594e1275e14fc2d1d54a76a9459c9fb1f2ddd12067d559',
     x86_64: 'ff17eb4d0c46216855e03ea20c6568f12ca4e07435a9f418af27a258da99af97'
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
