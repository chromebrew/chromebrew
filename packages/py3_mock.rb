require 'buildsystems/pip'

class Py3_mock < Pip
  description 'Mock is a testing library in Python.'
  homepage 'https://mock.readthedocs.org/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ef55f1726cc56696d364e63e9ad06570d51477be86d97f4e88a523e86c22c35',
     armv7l: '2ef55f1726cc56696d364e63e9ad06570d51477be86d97f4e88a523e86c22c35',
       i686: '1794d555568d117dbc65fe6499c7f21d1b0c137bec669699b599c5816509eba1',
     x86_64: 'e43dae2060bee3f8a9a3ead6a00e0d2121352be3dc16d40f567ee978eba7fd50'
  })

  no_source_build
end
