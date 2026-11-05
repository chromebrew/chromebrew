require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '409261d7d2d11ac0fa5f640ec80ef1d1113e9ae2cdb4b7db9919a17eeec549b4',
     armv7l: '409261d7d2d11ac0fa5f640ec80ef1d1113e9ae2cdb4b7db9919a17eeec549b4',
       i686: '57b8f98980ea2e00898939dc714df49e3fbbfb181ca96a812d08945c5b1b9b57',
     x86_64: 'a96dc7ee14ee56e806115e075fec6c9b477d554e6fbada89a6ca9d3c1e221a0c'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
