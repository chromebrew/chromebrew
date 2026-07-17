require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.30.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a8e4e99b3c08816677ad7d0da3d9e5311d784597a9803d11753d2f13e651f43',
     armv7l: '3a8e4e99b3c08816677ad7d0da3d9e5311d784597a9803d11753d2f13e651f43',
       i686: '613b64607717b82bd22f3031b304513dcc79aa68417ef6771b39521e15550ce2',
     x86_64: '0ad55fa430b93b9c38815f05ccc39ffa383b2a87314e1bbad1649b02111f67ac'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
