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
    aarch64: 'e969c50594b13a9ea7e098891778cc3e6ee9f0aafb23abdb8ae95ebbb3efcc53',
     armv7l: 'e969c50594b13a9ea7e098891778cc3e6ee9f0aafb23abdb8ae95ebbb3efcc53',
       i686: '1794d555568d117dbc65fe6499c7f21d1b0c137bec669699b599c5816509eba1',
     x86_64: '10ffc39d54d9396ffada35ab03ca515a3544ad3c478c1ac2b834c35d25d0f1bc'
  })

  no_source_build
end
