require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2612ebf53e38182f78c5f7dd2fa524b7b3db7fbc676481cc5d6d0b5419543897',
     armv7l: '2612ebf53e38182f78c5f7dd2fa524b7b3db7fbc676481cc5d6d0b5419543897',
       i686: 'b7a24274b36a9c0e9e66ff0605c8365d902a5c49a38de76c74d9706faa6d409c',
     x86_64: 'bd75571edbd283baf2e08182039c977c02c105a3c5bc21294b50c706d82a068d'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
