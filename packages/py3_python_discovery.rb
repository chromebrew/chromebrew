require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.9.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ee3bec3b10b2385dc37577b44bbbbeaf45c1381ada7b4c31fb95abc75e2a10c',
     armv7l: '9ee3bec3b10b2385dc37577b44bbbbeaf45c1381ada7b4c31fb95abc75e2a10c',
       i686: 'ad84a58a928772907c96343e6e61d842536bd4776fb0b0c437b60b275b6c1825',
     x86_64: '61b9dfeedc046815e32bbaa44767880048c527952e4bb819974c989945bcb587'
  })

  depends_on 'python3' => :logical

  no_source_build
end
