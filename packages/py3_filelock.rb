require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.29.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e36d913885707e55597902bfea3da12a57fb8064fb0a57ed200d3a4b37b90c4',
     armv7l: '3e36d913885707e55597902bfea3da12a57fb8064fb0a57ed200d3a4b37b90c4',
       i686: '16c66ff9b543b7bb80f9e527266031b3a184c8e368c140a2f5eabc868f14fc75',
     x86_64: '79b541d107887fb2241ceab7460195788b8e3d82e8ae2ce8e77931a93f8d9fcc'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
