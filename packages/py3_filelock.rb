require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.31.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a0bee90d818963cd0377a03081104b14456840730d6fa677965289e8201415f',
     armv7l: '4a0bee90d818963cd0377a03081104b14456840730d6fa677965289e8201415f',
       i686: '4178a756e67701de2ba817028fbdc75a5e20621fed8f04904c661cbde1b47a43',
     x86_64: '7dd0c989ce95eab58ce5e1fe7ca8ad5d3da8b5052c792db9f0dbb3cddaafad23'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
