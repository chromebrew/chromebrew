require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.29.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1c40ac38000a9cd36c1fab36526523375c809ce1fa868403931a69fe0e4a0eeb',
     armv7l: '1c40ac38000a9cd36c1fab36526523375c809ce1fa868403931a69fe0e4a0eeb',
       i686: '4528a053eecdd732ad2ffb60aceeb6fae2759650d5d2372b78c7cdad967f458f',
     x86_64: 'e9c16dcf0909caa8e5fb0d725dde8843bc0dc034d431d6fdc64f0d5d357d3e39'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
