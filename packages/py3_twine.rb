require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "6.2.0-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '73e4ac8bb0ba50b7bfe36b448abeb5bc52700e5fcc8e79da16bd02a13e96d52c',
     armv7l: '73e4ac8bb0ba50b7bfe36b448abeb5bc52700e5fcc8e79da16bd02a13e96d52c',
       i686: '9e5a960baf956b3934d2920fb7aa19ccdb81ae62ba494d427a3e1a881bfbb425',
     x86_64: '61e56df0542895ad70710957995b19b24c11188d6c4c6371e10e9d9e851b4574'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
