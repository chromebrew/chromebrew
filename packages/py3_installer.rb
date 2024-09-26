require 'buildsystems/pip'

class Py3_installer < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://installer.readthedocs.io/'
  version "0.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c7fe27c3838cf3f05968ff942ef10bf7ad467e4a9c6942383c0971f0cad06ce',
     armv7l: '3c7fe27c3838cf3f05968ff942ef10bf7ad467e4a9c6942383c0971f0cad06ce',
       i686: '26725aff97d70fe2f32170b4ec1837f4ec03083a3f93263990a4e6b66151bec2',
     x86_64: '127d9f286cc696651d36e1ccfc0f31392c1cec060f454e6689c668fc456c563b'
  })

  depends_on 'python3'

  no_source_build
end
