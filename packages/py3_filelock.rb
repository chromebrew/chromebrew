require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.28.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5def5d1232e6f13fd24eb33b9aa4c37a669f9a7f0530f2d9ed8398058d855a07',
     armv7l: '5def5d1232e6f13fd24eb33b9aa4c37a669f9a7f0530f2d9ed8398058d855a07',
       i686: '2ae836ef513dd52503fc5ddec830a542e4a71534a89a3453b52fe57c3281818c',
     x86_64: '6e295197cb66d218cd04042de27def3f129912dcff5ecbec84c90edd39312815'
  })

  depends_on 'python3' => :logical

  no_source_build
end
