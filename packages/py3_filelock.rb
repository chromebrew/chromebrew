require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.24.1-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09b4a324a49845c5539dbce8c651a778b3dde8d4ee09d18e90db309d1eeb13c9',
     armv7l: '09b4a324a49845c5539dbce8c651a778b3dde8d4ee09d18e90db309d1eeb13c9',
       i686: 'ea3eeb42da455fe90b90bc8bb5e4d91c4f27034ee2cb683045aeb87e7b78e758',
     x86_64: 'ded3b202c627f5d2630d2a01d5398546f21d32e65e42c6d6d577d80b61433a9c'
  })

  depends_on 'python3' => :build

  no_source_build
end
