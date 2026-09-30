require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '908558056f433d1704d56f57d5ee8409750ddedb550b3a3f5901cc59228cc71f',
     armv7l: '908558056f433d1704d56f57d5ee8409750ddedb550b3a3f5901cc59228cc71f',
       i686: '0ee701dd80a2d61d6deaf2ca40fab4c96c29c085effdddafe7bf7b4925b61537',
     x86_64: '27efd716f8409fe02fd6a9e16cbc8542a8479414fd34e51a673b9923d4ad6636'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
