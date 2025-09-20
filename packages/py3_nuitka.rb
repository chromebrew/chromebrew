require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.16-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a01cff850c0cc023cc8b9450a248a21abeb01e71ba9493005c652bfea17b576e',
     armv7l: 'a01cff850c0cc023cc8b9450a248a21abeb01e71ba9493005c652bfea17b576e',
       i686: '836bb3b2aa412c153ec983dc42dda29b3671df80eca22ed8ca18ec04945a1800',
     x86_64: '64e592f9e6c0a5a3761098f826fe75b92021059760d314a27a2eb95badebe7d4'
  })

  depends_on 'python3' => :build

  no_source_build
end
