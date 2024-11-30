require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "6.0.0-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b48e65fda1a72158d3909e9ed534fe15f4c0644756e37e9726d857d4ae94e927',
     armv7l: 'b48e65fda1a72158d3909e9ed534fe15f4c0644756e37e9726d857d4ae94e927',
       i686: 'ce48f9f7ef59204077358f8be2b8372667ab34d3f930b6aaa41db465d3e83719',
     x86_64: '6314a131c4d5ea96f129d070246bf0a736d27ffcdea19a8c669862d76a2eed79'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
