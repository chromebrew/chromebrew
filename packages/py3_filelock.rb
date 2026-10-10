require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a44afccfacdcf7c76a15c0e00662fb01dfbe209e82d5ff3415c93ecbf7643ed2',
     armv7l: 'a44afccfacdcf7c76a15c0e00662fb01dfbe209e82d5ff3415c93ecbf7643ed2',
       i686: '85c8ea9e331c5760a3296cd981016319e071eecf71275b600d04173b50f64372',
     x86_64: '864745cbf4b6310352dd5517d6e3926b3575e02829f4eb299aee3c729ebc5564'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
